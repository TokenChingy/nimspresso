import ../src/nimspresso

import ./middlewares/logger
import ./resources/health

proc onExit() {.noconv.} =
  quit()

setControlCHook(onExit)

let app = Application(
  beforeResource: @[loggerMiddleware],
  afterResource: @[],
  resources: @[Resource(healthResource)]
)

waitFor app.serve(
  3000,
  "127.0.0.1"
)