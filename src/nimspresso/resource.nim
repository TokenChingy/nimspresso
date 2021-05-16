import zfblast

import context

type
  Resource* = ref object of RootObj
    paths*: seq[string]

method GET*(self: Resource, ctx: Context): Future[void] {.async, base.} =
  ctx.response.httpCode = Http501
  ctx.response.body = $Http501

  await ctx.resp()
  
method HEAD*(self: Resource, ctx: Context): Future[void] {.async, base.} =
  ctx.response.httpCode = Http501
  ctx.response.body = $Http501

  await ctx.resp()

method POST*(self: Resource, ctx: Context): Future[void] {.async, base.} =
  ctx.response.httpCode = Http501
  ctx.response.body = $Http501

  await ctx.resp()

method PUT*(self: Resource, ctx: Context): Future[void] {.async, base.} =
  ctx.response.httpCode = Http501
  ctx.response.body = $Http501

  await ctx.resp()

method DELETE*(self: Resource, ctx: Context): Future[void] {.async, base.} =
  ctx.response.httpCode = Http501
  ctx.response.body = $Http501

  await ctx.resp()

method CONNECT*(self: Resource, ctx: Context): Future[void] {.async, base.} =
  ctx.response.httpCode = Http501
  ctx.response.body = $Http501

  await ctx.resp()

method OPTIONS*(self: Resource, ctx: Context): Future[void] {.async, base.} =
  ctx.response.httpCode = Http501
  ctx.response.body = $Http501

  await ctx.resp()

method TRACE*(self: Resource, ctx: Context): Future[void] {.async, base.} =
  ctx.response.httpCode = Http501
  ctx.response.body = $Http501

  await ctx.resp()

method PATCH*(self: Resource, ctx: Context): Future[void] {.async, base.} =
  ctx.response.httpCode = Http501
  ctx.response.body = $Http501

  await ctx.resp()