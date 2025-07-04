local ide_mode = os.getenv("NVIM_IDE")
local ct = require("samporapeli.concatable")
local conditionally = require("samporapeli.conditionally")

return ct.new(require("samporapeli.plugins.basic")) ..
  conditionally(ide_mode).if_true(require("samporapeli.plugins.ide")).if_false({})
