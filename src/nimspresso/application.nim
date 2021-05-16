import asyncfile
import tables
import times

import zfblast

import context
import middleware
import resource

type
  Application* = ref object of RootObj
    beforeResource*: seq[Middleware]
    resources*: seq[Resource]
    afterResource*: seq[Middleware]
    routes: Table[string, Resource]
    server: ZFBlast

proc startup(self: Application): Future[void] {.async.} =
  self.routes = initTable[string, Resource]()
  
  for _, resource in self.resources:
    for _, path in resource.paths:
      self.routes[path] = resource

proc parseBody(self: Application, ctx: Context): Future[void] {.async.} =
  if ctx.request.headers.hasKey("content-type"):
    let contentType: string = ctx.request.headers["content-type"]
    let bodyFile: AsyncFile = openAsync(ctx.request.body)
    let bodyString: string = await readAll(bodyFile)

    close(bodyFile)

    echo(contentType)

    if contentType.contains("form-data"):
      echo("form-data")
    else:
      case contentType:
      of "x-www-form-urlencoded":
        echo("application/x-www-form-urlencoded")
      of "application/json":
        echo("application/json")

    # echo(bodyString)

proc before(self: Application, ctx: Context): Future[void] {.async.} =
  if len(self.beforeResource) > 0:
    for _, middleware in self.beforeResource:
      await middleware(ctx)

proc after(self: Application, ctx: Context): Future[void] {.async.} =
  if len(self.afterResource) > 0:
    for _, middleware in self.afterResource:
      await middleware(ctx)

proc route(self: Application, ctx: Context): Future[void] {.async.} =
  let path: string = ctx.request.url.getPath()
  let code: HttpMethod = ctx.request.httpMethod

  var pathFound: bool = false

  if self.routes.hasKey(path):
    pathFound = true

    case code:
      of HttpGet:
        await self.routes[path].GET(ctx)
      of HttpHead:
        await self.routes[path].HEAD(ctx)
      of HttpPost:
        await self.routes[path].POST(ctx)
      of HttpPut:
        await self.routes[path].PUT(ctx)
      of HttpDelete:
        await self.routes[path].DELETE(ctx)
      of HttpConnect:
        await self.routes[path].CONNECT(ctx)
      of HttpOptions:
        await self.routes[path].OPTIONS(ctx)
      of HttpTrace:
        await self.routes[path].TRACE(ctx)
      of HttpPatch:
        await self.routes[path].PATCH(ctx)
  else:
    let pathSegments = path.split("/")

    for route, resource in self.routes.pairs():
      let routeSegments = route.split("/")

      if len(pathSegments) != len(routeSegments):
        continue
      else:
        var segment = 0

        while segment < len(pathSegments):
          let pathSegment = pathSegments[segment]
          let routeSegment = routeSegments[segment]

          if routeSegment.startsWith("{") and routeSegment.endsWith("}") and len(routeSegment) > 2:
            ctx.pathParams[routeSegment[1..^2]] = pathSegment
            inc(segment)
          else:
            if routeSegment == pathSegment:
              inc(segment)
            else:
              break
          
          if segment == len(pathSegments):
            pathFound = true

            case code:
              of HttpGet:
                await self.routes[route].GET(ctx)
              of HttpHead:
                await self.routes[route].HEAD(ctx)
              of HttpPost:
                await self.routes[route].POST(ctx)
              of HttpPut:
                await self.routes[route].PUT(ctx)
              of HttpDelete:
                await self.routes[route].DELETE(ctx)
              of HttpConnect:
                await self.routes[route].CONNECT(ctx)
              of HttpOptions:
                await self.routes[route].OPTIONS(ctx)
              of HttpTrace:
                await self.routes[route].TRACE(ctx)
              of HttpPatch:
                await self.routes[route].PATCH(ctx)
            break
    
  if not pathFound:
    ctx.response.httpCode = Http404
    ctx.response.body = $Http404

    await ctx.resp()

proc serve*(self: Application, port: uint16, hostname: string = "127.0.0.1", debug: bool = false): Future[void] {.async.} =
  await self.startup()
  
  self.server = newZFBlast(
    hostname,
    Port(port),
    debug
  )

  self.server.serve(proc (zfCtx: HttpContext): Future[void] {.async.} =
    let ctx: Context = cast[Context](zfCtx)

    ctx.pathParams = initTable[string, string]()
    
    await self.parseBody(ctx)
    await self.before(ctx)
    await self.route(ctx)
    await self.after(ctx)
  )