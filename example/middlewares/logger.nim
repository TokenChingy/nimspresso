import strformat
import times

import ../../src/nimspresso

proc loggerMiddleware*(ctx: Context): Future[void] {.async, gcsafe, nimcall.} =
  if ctx.routed:
    echo(fmt"{now()} - {ctx.response.httpCode} - {ctx.request.url.getPath()}")
  else:
    echo(fmt"{now()} - {ctx.request.httpMethod} - {ctx.request.url.getPath()}")
