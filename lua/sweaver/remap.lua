-- <leader> -------------------------------------------------------------------
vim.g.mapleader = " "
-------------------------------------------------------------------------------

-- project --------------------------------------------------------------------
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-------------------------------------------------------------------------------

-- window ---------------------------------------------------------------------
vim.keymap.set("n", "<C-h>", [[<C-w>h]])
vim.keymap.set("n", "<C-j>", [[<C-w>j]])
vim.keymap.set("n", "<C-k>", [[<C-w>k]])
vim.keymap.set("n", "<C-l>", [[<C-w>l]])
-------------------------------------------------------------------------------

-- terminal -------------------------------------------------------------------
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]])
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]])
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]])
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]])

-- open terminal
vim.keymap.set("n", "<leader>tr", function()
	vim.cmd("rightbelow vsplit | terminal")
	vim.cmd("vertical resize 80")
end, { desc = "open terminal on the right" })

-- resize terminal function
local function resize_terminal(delta)
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.api.nvim_buf_get_option(buf, "buftype") == "terminal" then
			vim.api.nvim_win_call(win, function()
				vim.cmd("vertical resize " .. delta)
			end)
			break
		end
	end
end

-- resize terminal keybinds
vim.keymap.set("n", "<leader>+", function() resize_terminal("+5") end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>-", function() resize_terminal("-5") end, { noremap = true, silent = true })
-------------------------------------------------------------------------------

-- Go -------------------------------------------------------------------------

-- run Go
vim.keymap.set("n", "<leader>gr", function()
	local term_win = nil
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].buftype == "terminal" then
			term_win = win
			break
		end
	end
	if term_win then
		vim.api.nvim_set_current_win(term_win)
	else
		vim.cmd("rightbelow vsplit | terminal")
		vim.cmd("vertical resize 80")
	end
	vim.fn.chansend(vim.b.terminal_job_id, "go run .\n")
end, { desc = "smart Go run in terminal" })

-- test Go
vim.keymap.set("n", "<leader>gt", function()
	local term_win = nil
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].buftype == "terminal" then
			term_win = win
			break
		end
	end
	if not term_win then
		vim.cmd("rightbelow vsplit | terminal")
		vim.cmd("vertical resize 80")
	else
		vim.api.nvim_set_current_win(term_win)
	end
	vim.fn.chansend(vim.b.terminal_job_id, "go test -v ./...\n")
end, { desc = "run Go tests" })
-------------------------------------------------------------------------------
