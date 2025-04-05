require("sweaver.remap")
require("sweaver.packer")

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.opt_local.number = true
    vim.opt_local.relativenumber = true
  end
})

-- whitespace
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.list = true
vim.opt.listchars = {
	tab = '▸ ',
	trail = '·',
	extends = '⟩',
	precedes = '⟨'
}

