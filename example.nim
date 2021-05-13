import json
import tables

import src/nimspresso

type
  HealthResource* = ref object of Resource

method GET*(self: HealthResource, ctx: Context): Future[void] {.async.} =
  ctx.response.httpCode = Http202
  ctx.response.body = $Http202

let healthResource = HealthResource(paths: @["/api/health"])

type
  UserResource* = ref object of Resource

method GET*(self: UserResource, ctx: Context): Future[void] {.async.} =
  var id: string = ctx.pathParams.getOrDefault("id")

  ctx.response.httpCode = Http202
  ctx.response.body = $(%*[
    {
      "id": id
    }
  ])

let userResource = UserResource(paths: @["/api/user/{id}"])

proc logPath*(ctx: Context): Future[void] {.async.} =
  echo(ctx.request.url.getPath())

let app = Application(
  beforeResource: @[Middleware(logPath)],
  afterResource: @[],
  resources: @[Resource(healthResource), Resource(userResource)]
)

waitFor app.serve(
  port = 3000,
  hostname = "localhost",
  debug = true
)