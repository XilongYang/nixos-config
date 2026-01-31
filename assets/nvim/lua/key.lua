vim.keymap.set('n', '<C-s>', ':w<CR>', {silent = true})
vim.keymap.set('i', '<C-s>', '<ESC>:w<CR>a', {silent = true})

vim.keymap.set('v', '<C-c>', 'y', {silent = true})
vim.keymap.set('i', '<C-v>', '<ESC>p', {silent = true})

vim.keymap.set('n', '<C-h>', '<C-w>h', {silent = true})
vim.keymap.set('n', '<C-j>', '<C-w>j', {silent = true})
vim.keymap.set('n', '<C-k>', '<C-w>k', {silent = true})
vim.keymap.set('n', '<C-l>', '<C-w>l', {silent = true})

vim.keymap.set('n', 'gt', ':NvimTreeToggle<CR>', {silent = true})

vim.keymap.set('n', 'gp', ':BufferLinePick<CR>', {silent = true})
vim.keymap.set('n', 'gP', ':BufferLinePickClose<CR>', {silent = true})

vim.keymap.set('n', 'gl', ':BufferLineCycleNext<CR>', {silent = true})
vim.keymap.set('n', 'gh', ':BufferLineCyclePrev<CR>', {silent = true})


vim.keymap.set("n", "ga", "<cmd>AerialToggle!<CR>")



vim.keymap.set("n", "ge", vim.diagnostic.open_float, { silent = true })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { silent = true })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { silent = true })
