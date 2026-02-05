-- ============================================================================
-- NVIM-JDTLS: Enhanced Java LSP support for Neovim
-- ============================================================================
-- A plugin that provides extended Java development capabilities using the
-- Eclipse JDT Language Server (jdtls). Offers features beyond standard LSP
-- including code generation, refactoring, and debugging support.
--
-- Features:
--   - Full Java LSP support via Eclipse jdtls
--   - Code actions, refactoring, and organize imports
--   - Integration with nvim-dap for Java debugging
--   - Support for Maven and Gradle projects
--
-- Loads automatically for Java files (ft = "java").
-- ============================================================================
return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  dependencies = {
    "mfussenegger/nvim-dap",
  },
}
