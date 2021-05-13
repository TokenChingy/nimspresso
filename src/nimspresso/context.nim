import tables
import times

import zfblast

type
  Context* = ref object of HttpContext
    routed*: bool
    pathParams*: Table[string, string]