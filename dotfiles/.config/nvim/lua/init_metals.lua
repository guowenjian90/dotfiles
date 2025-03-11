metals_config = require'metals'.bare_config()
metals_config.settings = {
   showImplicitArguments = false,  -- Reduces verbosity
   defaultBspToBuildTool = true,
   verboseCompilation = false,
   excludedPackages = {
     "akka.actor.typed.javadsl",
     "com.github.swagger.akka.javadsl",
     "java",
     "scala",
   }
}

-- metals_config.on_attach = function()
--   require'cmp'.on_attach();
-- end

    -- Optionally suppress other LSP notifications
metals_config.handlers["window/showMessage"] = function(_, params)
  if params.type == vim.lsp.protocol.MessageType.Info then
    return  -- Blocks "Info" level messages (e.g., "Compiled")
  end
end

vim.g.metals_suppress_build_import_prompt = true
metals_config.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      prefix = '',
    }
  }
)

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
   pattern = { "scala", "sbt", "java" },
   callback = function()
     require("metals").initialize_or_attach(metals_config)
   end,
   group = nvim_metals_group,
 })
