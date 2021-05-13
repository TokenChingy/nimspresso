import tables

import zfblast

type
  Context* = ref object of HttpContext
    pathParams*: Table[string, string]