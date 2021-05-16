import strformat
import times

import ../../src/nimspresso

proc loggerMiddleware*(ctx: Context): Future[void] {.async, gcsafe, nimcall.} =
  echo(fmt"{now()} - {ctx.response.httpCode} - {ctx.request.httpMethod} - {ctx.request.url.getPath()}")
