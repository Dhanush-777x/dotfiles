return {
	-- Telescope main plugin
	{
		"nvim-telescope/telescope.nvim",
		-- Remove lazy loading for simplicity while testing
		-- event = "VeryLazy", 
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			-- Basic setup for Telescope
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			-- Load ui-select extension
			require("telescope").load_extension("ui-select")

			-- Define keybindings for testing
			vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
			vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })
			vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })
			vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<CR>', { noremap = true, silent = true })
		end,
	},
	
	-- ui-select extension for Telescope
	{
		"nvim-telescope/telescope-ui-select.nvim",
		-- Lazy loading is removed for testing
		-- lazy = true, 
	},
}

