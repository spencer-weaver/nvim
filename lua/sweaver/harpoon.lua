-- Harpoon --------------------------------------------------------------------
local harpoon = require("harpoon")
local ui = require("harpoon.ui")
local mark = require("harpoon.mark")

-- menu
vim.keymap.set("n", "<leader>h", function()
	ui.toggle_quick_menu()
end, { desc = "open Harpoon menu" })

-- adding
vim.keymap.set("n", "<leader>a", function()
	mark.add_file()
end, { desc = "add file to Harpoon list" })

-- navigation
for i = 1, 10 do
	vim.keymap.set("n", "<leader>" .. i % 10, function()
		ui.nav_file(i)
	end, { desc = "navigate to Harpoon file " .. i })
end

-- removing
vim.keymap.set("n", "<leader>r", function()
	mark.rm_file()
end, { desc = "remove Harpoon file" })
-------------------------------------------------------------------------------
