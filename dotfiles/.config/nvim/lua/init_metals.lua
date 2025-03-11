metals_config = require'metals'.bare_config()
metals_config.settings = {
   showImplicitArguments = true,
   defaultBspToBuildTool= true,
   excludedPackages = {
     "akka.actor.typed.javadsl",
     "com.github.swagger.akka.javadsl"
   }
}

-- metals_config.on_attach = function()
--   require'cmp'.on_attach();
-- end

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

