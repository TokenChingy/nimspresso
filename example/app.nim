import ../src/nimspresso

import ./middlewares/logger

import ./resources/health
import ./resources/pathParams

proc onExit() {.noconv.} =
  quit()

setControlCHook(onExit)

let app = Application(
  beforeResource: @[],
  afterResource: @[loggerMiddleware],
  resources: @[Resource(healthResource), Resource(pathParamsResource)]
)

waitFor app.serve(
  3000,
  "127.0.0.1"
)