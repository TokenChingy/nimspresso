import tables
import times

import zfblast

type
  Context* = ref object of HttpContext
    pathParams*: Table[string, string]