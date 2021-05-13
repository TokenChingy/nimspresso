import ../src/nimspresso

import ./middlewares/logger
import ./resources/health

let app = Application(
  beforeResource: @[loggerMiddleware],
  afterResource: @[loggerMiddleware],
  resources: @[Resource(healthResource)]
)

waitFor app.serve(
  3000,
  "127.0.0.1"
)