import asyncdispatch

import context

type
  Middleware* = proc (ctx: Context): Future[void] {.async, gcsafe, nimcall.}