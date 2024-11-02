local builtin = require('telescope.builtin')
-- \ff
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
-- \fg
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
-- \fb
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
-- \fh
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

require("telescope-tabs").setup({
	entry_formatter = function(tab_id, buffer_ids, file_names, file_paths, is_current)
		local entry_string = table.concat(vim.tbl_map(function(v)
			return vim.fn.fnamemodify(v, ":.")
		end, file_paths), ', ')
		return string.format('%d: %s%s', tab_id, entry_string, is_current and ' <' or '')
	end
})
