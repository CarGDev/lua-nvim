-- Cleanup script for deprecated debug adapters
-- Run this in Neovim with :lua loadfile("cleanup_deprecated_adapters.lua")()

local function cleanup_deprecated_adapters()
  local mason_registry = require("mason-registry")
  
  -- List of deprecated adapters to remove
  local deprecated_adapters = {
    "node-debug2-adapter",
    "chrome-debug-adapter"
  }
  
  print("🧹 Cleaning up deprecated debug adapters...")
  
  for _, adapter in ipairs(deprecated_adapters) do
    if mason_registry.is_installed(adapter) then
      print("🗑️  Uninstalling " .. adapter)
      mason_registry.uninstall(adapter)
    else
      print("✅ " .. adapter .. " is not installed")
    end
  end
  
  print("✨ Cleanup complete! Make sure to restart Neovim for changes to take effect.")
end

-- Run the cleanup
cleanup_deprecated_adapters() 