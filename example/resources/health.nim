import json
import times

import ../../src/nimspresso

type
  HealthResourece* = ref object of Resource

method GET*(self: HealthResourece, ctx: Context): Future[void] {.async.} =
  ctx.response.httpCode = Http200
  ctx.response.body = $(%*[
    {
      "datetime": $utc(now())
    }
  ])

let healthResource* = HealthResourece(paths: @["/api/health"])