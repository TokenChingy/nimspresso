import json
import tables
import times

import ../../src/nimspresso

type
  PathParamsResource* = ref object of Resource

method GET*(self: PathParamsResource, ctx: Context): Future[void] {.async.} =
  ctx.response.httpCode = Http200
  ctx.response.body = $(%*[
    {
      "id": ctx.pathParams["id"],
      "id2": ctx.pathParams["id2"]
    }
  ])

  await ctx.resp()

let pathParamsResource* = PathParamsResource(paths: @["/api/path/params/{id}/static/{id2}"])