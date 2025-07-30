local ct = require("samporapeli.concatable")

return ct.new(require("samporapeli.plugins.basic"))
  .. require("samporapeli.plugins.ide")
