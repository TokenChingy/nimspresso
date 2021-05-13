import zfblast

import context

type
  Resource* = ref object of RootObj
    paths*: seq[string]

method GET*(self: Resource, ctx: Context): Future[void] {.async, base.} =
  ctx.response.httpCode = Http501
  ctx.response.body = $Http501
  
method HEAD*(self: Resource, ctx: Context): Future[void] {.async, base.} =
  ctx.response.httpCode = Http501
  ctx.response.body = $Http501

method POST*(self: Resource, ctx: Context): Future[void] {.async, base.} =
  ctx.response.httpCode = Http501
  ctx.response.body = $Http501

method PUT*(self: Resource, ctx: Context): Future[void] {.async, base.} =
  ctx.response.httpCode = Http501
  ctx.response.body = $Http501

method DELETE*(self: Resource, ctx: Context): Future[void] {.async, base.} =
  ctx.response.httpCode = Http501
  ctx.response.body = $Http501

method CONNECT*(self: Resource, ctx: Context): Future[void] {.async, base.} =
  ctx.response.httpCode = Http501
  ctx.response.body = $Http501

method OPTIONS*(self: Resource, ctx: Context): Future[void] {.async, base.} =
  ctx.response.httpCode = Http501
  ctx.response.body = $Http501

method TRACE*(self: Resource, ctx: Context): Future[void] {.async, base.} =
  ctx.response.httpCode = Http501
  ctx.response.body = $Http501

method PATCH*(self: Resource, ctx: Context): Future[void] {.async, base.} =
  ctx.response.httpCode = Http501
  ctx.response.body = $Http501