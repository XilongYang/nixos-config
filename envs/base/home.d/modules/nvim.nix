{ config, ... }:
{
  xdg.configFile."nvim/init.lua".text = ''
    require('plugins')
    require('colorscheme')
    require('opts')
    require('key')
  '';

  xdg.configFile."nvim/lazy-lock.json".text = ''
    {
      "aerial.nvim": { "branch": "master", "commit": "c7cbbad40c2065fccfd1f1863bb2c08180c0533d" },
      "blink.cmp": { "branch": "main", "commit": "327fff91fe6af358e990be7be1ec8b78037d2138" },
      "bufferline.nvim": { "branch": "main", "commit": "655133c3b4c3e5e05ec549b9f8cc2894ac6f51b3" },
      "copilot.lua": { "branch": "master", "commit": "abc8bda97271624051f814ec8a06088e658359ed" },
      "fcitx.nvim": { "branch": "master", "commit": "dcb6b70888aa893d3d223bb777d4117bbdac06a7" },
      "friendly-snippets": { "branch": "main", "commit": "572f5660cf05f8cd8834e096d7b4c921ba18e175" },
      "lazy.nvim": { "branch": "main", "commit": "6c3bda4aca61a13a9c63f1c1d1b16b9d3be90d7a" },
      "nvim-colorizer.lua": { "branch": "master", "commit": "51cf7c995ed1eb6642aecf19067ee634fa1b6ba2" },
      "nvim-lspconfig": { "branch": "master", "commit": "336b388c272555d2ae94627a50df4c2f89a5e257" },
      "nvim-tree.lua": { "branch": "master", "commit": "e179ad2f83b5955ab0af653069a493a1828c2697" },
      "nvim-treesitter": { "branch": "master", "commit": "42fc28ba918343ebfd5565147a42a26580579482" },
      "nvim-web-devicons": { "branch": "master", "commit": "6e51ca170563330e063720449c21f43e27ca0bc1" },
      "toggleterm.nvim": { "branch": "main", "commit": "50ea089fc548917cc3cc16b46a8211833b9e3c7c" },
      "tokyonight.nvim": { "branch": "main", "commit": "ca56e536f565293b83a075971fb5880cfe41d6de" }
    }
  '';

  xdg.configFile."nvim/lua/colorscheme.lua".text = ''
    -- define your colorscheme here
    local colorscheme = 'tokyonight-night'
    
    local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
    if not is_ok then
        vim.notify('colorscheme ' .. colorscheme .. ' not found!')
        return
    end
  '';

  xdg.configFile."nvim/lua/key.lua".text = ''
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
    
    vim.keymap.set('n', 'gx', ':ToggleTerm<CR>', {silent = true})
    
    vim.keymap.set("n", "ga", "<cmd>AerialToggle!<CR>")
    
    vim.keymap.set("n", "<CR>", function()
      if not require("mdlink").open_md_link_under_cursor() then
        if not require("mdlink").fix_md_link_under_cursor() then
          local cr = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
          vim.api.nvim_feedkeys(cr, "n", false)
        end
      end
    end, { noremap = true, silent = true })
  '';

  xdg.configFile."nvim/lua/opts.lua".text = ''
    -- Hint: use `:h <option>` to figure out the meaning if needed
    vim.opt.clipboard = 'unnamedplus' -- use system clipboard
    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
    vim.opt.mouse = 'a' -- allow the mouse to be used in Nvim
    
    -- Tab
    vim.opt.tabstop = 4 -- number of visual spaces per TAB
    vim.opt.softtabstop = 4 -- number of spacesin tab when editing
    vim.opt.shiftwidth = 4 -- insert 4 spaces on a tab
    vim.opt.expandtab = true -- tabs are spaces, mainly because of python
    
    -- UI config
    vim.opt.number = true -- show absolute number
    vim.opt.relativenumber = true -- add numbers to each line on the left side
    vim.opt.cursorline = true -- highlight cursor line underneath the cursor horizontally
    vim.opt.splitbelow = true -- open new vertical split bottom
    vim.opt.splitright = true -- open new horizontal splits right
    -- vim.opt.termguicolors = true        -- enabl 24-bit RGB color in the TUI
    vim.opt.showmode = false -- we are experienced, wo don't need the "-- INSERT --" mode hint
    vim.opt.wrap = false
    
    -- Searching
    vim.opt.incsearch = true -- search as characters are entered
    vim.opt.hlsearch = false -- do not highlight matches
    vim.opt.ignorecase = true -- ignore case in searches by default
    vim.opt.smartcase = true -- but make it case sensitive if an uppercase is entered
    
    -- Undo
    vim.opt.undofile = true
    vim.opt.undodir = vim.fn.expand("~/.local/state/nvim/undo//")
    
    -- Backup
    vim.opt.backup = true
    vim.opt.backupdir = vim.fn.expand("~/.local/state/nvim/backup//")
    
    -- Autosave Notes
    vim.api.nvim_create_autocmd({"BufLeave", "FocusLost"}, {
        callback = function(args)
            local bufpath = vim.fn.expand(args.file)
            if bufpath:find(vim.fn.expand("~/Notes"), 1, true) then
                vim.cmd("silent! update")
            end
        end,
    })
  '';

  xdg.configFile."nvim/lua/plugins.lua".text = ''
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
      vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
      })
    end
    vim.opt.rtp:prepend(lazypath)
    
    require("lazy").setup({
        -- Theme
        {
            "folke/tokyonight.nvim",
            lazy = false,
            priority = 1000,
            opts = {},
        },
        {"zbirenbaum/copilot.lua"},
        {"h-hg/fcitx.nvim"},
        {"nvim-tree/nvim-tree.lua"},
        {'akinsho/toggleterm.nvim', version = "*", config = true},
        {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
        {
          'stevearc/aerial.nvim',
          opts = {},
          -- Optional dependencies
          dependencies = {
             "nvim-treesitter/nvim-treesitter",
             "nvim-tree/nvim-web-devicons"
          }
        },
        {
          "NvChad/nvim-colorizer.lua",
          config = function()
            require("colorizer").setup({
              user_default_options = {
                names = false,      -- 识别颜色名如 red/blue
                rgb_fn = true,
                hsl_fn = true,
              },
            })
          end
        },
        -- Completions
        {
           "saghen/blink.cmp",
           dependencies = { "rafamadriz/friendly-snippets" },
           version = "*",
           opts = {
               keymap = {
                   preset = "super-tab",
                   ["<Up>"] = { "select_prev", "fallback" },
                   ["<Down>"] = { "select_next", "fallback" },
                   ["<C-j>"] = { "select_next", "fallback" },
                   ["<C-k>"] = { "select_prev", "fallback" },
                   ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                   ["<C-f>"] = { "scroll_documentation_down", "fallback" },
                   ["<C-y>"] = { "show_signature", "hide_signature", "fallback" },
               },
               appearance = {
                   nerd_font_variant = "mono",
               },
               sources = {
                   default = { "lsp", "path", "snippets", "buffer" },
               },
               fuzzy = { implementation = "prefer_rust_with_warning" },
               completion = {
                   keyword = { range = "prefix" },
                   menu = {
                       draw = {
                           treesitter = { "lsp" },
                       },
                   },
                   trigger = { show_on_trigger_character = true },
                   documentation = {
                       auto_show = true,
                   },
               },
               signature = { enabled = true },
           },
           opts_extend = { "sources.default" },
        },
        {
          "init-lsp",
          dir = "~/.config/nvim",  -- 只是一个占位触发加载
          config = function()
            require("lsp")
          end,
        },
    })
    
    require("nvim-tree").setup()
    require("bufferline").setup()
    require("aerial").setup({
      -- optionally use on_attach to set keymaps when aerial has attached to a buffer
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
    })
    
    require("copilot").setup({
      suggestion = {
      enabled = true,
      auto_trigger = true,
      },
    })

  '';

  xdg.configFile."nvim/lua/mdlink.lua".text = ''
    -- 在 Normal 模式下，如果光标附近是 [text](path.md) 就跳转/新建 path.md
    local M = {}
    
    function link_under_cursor(line)
      local pos  = vim.api.nvim_win_get_cursor(0)      -- {row, col}
      local col  = pos[2] + 1                           -- 1-based
      if line == "" then return end
    
      -- 向左找最近的 '['
      local lb
      for i = col, 1, -1 do
        if line:sub(i, i) == "[" then lb = i; break end
      end
      if not lb then return end
    
      -- 向右找最近的 ')'
      local rp
      for i = col, #line do
        if line:sub(i, i) == ")" then rp = i; break end
      end
      if not rp or rp <= lb then return end
    
      return lb, rp
    end
    
    
    function M.open_md_link_under_cursor()
      local line = vim.api.nvim_get_current_line()
      local lb, rp = link_under_cursor(line)
      if not lb or not rp then return false end
      local seg = line:sub(lb, rp)
    
      -- 取 () 内路径
      local path = seg:match("%b[]%(([^)]+)%)")
      if not path or not path:match("%.md$") then return false end
    
      -- 解析为绝对路径（相对按当前缓冲区目录）
      local target
      if path:sub(1,1) == "/" or path:sub(1,1) == "~" then
        target = vim.fn.expand(path)
      else
        target = vim.fn.expand("%:p:h") .. "/" .. path
      end
      target = vim.fn.fnamemodify(target, ":p")
    
      -- 确保目录存在
      local dir = vim.fn.fnamemodify(target, ":h")
      if dir ~= "" and vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
      end
    
      -- 跳转/新建
      vim.cmd.edit(vim.fn.fnameescape(target))
      return true
    end
    
    function M.fix_md_link_under_cursor()
      local line = vim.api.nvim_get_current_line()
      local lb, rp = link_under_cursor(line)
      if not lb or not rp then return false end
      local seg = line:sub(lb, rp)
    
      -- 取 [] 内路径
      -- 检查格式是否匹配[text]()
      -- Lua语言中，^表示字符串开头，$表示字符串结尾，%为转义字符
      if not seg or not seg:match("^%[.+%]%(%)$") then return false end
    
      -- 提取路径
      -- 这里会提取出([^%]]+)部分，也就是[]内的内容, 其中[^%]]为[^x](%])，即非]字符
      local text = seg:match("%[([^%]]+)%]%(%)")
    
      -- 将seg部分的()替换为(./text.md)
      local new_seg = seg:gsub("%(%)", "(./" .. text .. ".md)")
    
      -- 替换文件中的该部分
      local new_line = line:sub(1, lb - 1) .. new_seg .. line:sub(rp + 1)
      vim.api.nvim_set_current_line(new_line)
      return true
    end
    
    return M
  '';

  xdg.configFile."nvim/lua/lsp.lua".text = ''
    -- ~/.config/nvim/lua/config/lsp.lua
    -- 纯 vim.lsp.config（Neovim 0.11+）
    -- 补全能力对接 blink.cmp
    
    -- === blink.cmp 能力 ===
    local ok_blink, blink = pcall(require, "blink.cmp")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    if ok_blink and blink.get_lsp_capabilities then
      capabilities = blink.get_lsp_capabilities(capabilities)
    end
    
    -- === root_pattern：用 vim.fs.find 实现 ===
    local function root_pattern(...)
      local patterns = { ... }
      return function(startpath)
        local path = startpath
        if type(path) ~= "string" or path == "" then
          local name = vim.api.nvim_buf_get_name(0)
          path = (name ~= "" and name) or vim.uv.cwd()
        end
        path = vim.fs.dirname(path)
        local found = vim.fs.find(patterns, { path = path, upward = true, type = "file" })
        return (found and found[1]) and vim.fs.dirname(found[1]) or nil
      end
    end
    
    -- === on_attach：常用键位 ===
    local function on_attach(_, bufnr)
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end
      map("n", "gd", vim.lsp.buf.definition, "LSP: Go to definition")
      map("n", "gr", vim.lsp.buf.references, "LSP: References")
      map("n", "gi", vim.lsp.buf.implementation, "LSP: Implementation")
      map("n", "K",  vim.lsp.buf.hover, "LSP: Hover")
      map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
      map("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: Code Action")
      map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, "LSP: Format")
    end
    
    -- === 轻量“框架”：把服务器注册到 vim.lsp.config 并设置 FileType 自动启动 ===
    local function register_server(name, default_config)
      local M = {}
      M.default_config = default_config
      function M.setup(user_cfg)
        local cfg = vim.tbl_deep_extend("force", default_config, user_cfg or {})
        vim.api.nvim_create_autocmd("FileType", {
          pattern = cfg.filetypes or {},
          group = vim.api.nvim_create_augroup("lsp_auto_start_" .. name, { clear = true }),
          callback = function(ev)
            -- 计算 root_dir
            local bufname = vim.api.nvim_buf_get_name(ev.buf)
            local root = (type(cfg.root_dir) == "function") and cfg.root_dir(bufname) or cfg.root_dir
            if not root and cfg.single_file_support ~= false then
              root = vim.fs.dirname(bufname ~= "" and bufname or vim.uv.cwd())
            end
            if not root then return end
    
            vim.lsp.start({
              name = name,
              cmd = cfg.cmd,
              root_dir = root,
              settings = cfg.settings,
              capabilities = cfg.capabilities,
              on_attach = function(client, bufnr)
                if cfg.on_attach then cfg.on_attach(client, bufnr) end
              end,
              init_options = cfg.init_options,
              single_file_support = cfg.single_file_support ~= false,
            })
          end,
        })
      end
      vim.lsp.config[name] = M
    end
    
    ----------------------------------------------------------------
    -- === 定义各语言最小可用 default_config（cmd 需在 PATH 中） ===
    ----------------------------------------------------------------
    
    -- Lua (lua-language-server)
    register_server("lua_ls", {
      cmd = { "lua-language-server" },
      filetypes = { "lua" },
      root_dir = root_pattern(".git", ".luarc.json", ".luarc.jsonc"),
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          hint = { enable = true },
        },
      },
      capabilities = capabilities,
      on_attach = on_attach,
    })
    
    -- C/C++ (clangd)
    register_server("clangd", {
      cmd = { "clangd" },
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
      root_dir = root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
      capabilities = capabilities,
      on_attach = on_attach,
    })
    
    -- Bash (bash-language-server)
    register_server("bashls", {
      cmd = { "bash-language-server", "start" },
      filetypes = { "sh", "bash" },
      root_dir = root_pattern(".git"),
      capabilities = capabilities,
      on_attach = on_attach,
    })
    
    -- SQL (sqls)
    register_server("sqls", {
      cmd = { "sqls" },
      filetypes = { "sql" },
      root_dir = root_pattern("sqls.yml", "sqls.yaml", ".git"),
      capabilities = capabilities,
      on_attach = on_attach,
    })
    
    -- TypeScript/JavaScript (typescript-language-server)
    register_server("ts_ls", {
      cmd = { "typescript-language-server", "--stdio" },
      filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx", "mjs", "cjs" },
      root_dir = root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
      init_options = { hostInfo = "neovim" },
      capabilities = capabilities,
      on_attach = on_attach,
    })
    
    -- HTML
    register_server("html", {
      cmd = { "vscode-html-language-server", "--stdio" },
      filetypes = { "html" },
      root_dir = root_pattern(".git"),
      capabilities = capabilities,
      on_attach = on_attach,
    })
    
    -- CSS
    register_server("cssls", {
      cmd = { "vscode-css-language-server", "--stdio" },
      filetypes = { "css", "scss", "less" },
      root_dir = root_pattern(".git"),
      capabilities = capabilities,
      on_attach = on_attach,
    })
    
    -- JSON
    register_server("jsonls", {
      cmd = { "vscode-json-language-server", "--stdio" },
      filetypes = { "json", "jsonc" },
      root_dir = root_pattern(".git"),
      capabilities = capabilities,
      on_attach = on_attach,
    })
    
    -- Scheme / Racket
    register_server("racket_langserver", {
      cmd = { "racket", "-l", "racket-langserver" },
      filetypes = { "racket", "scheme" },
      root_dir = root_pattern(".git"),
      capabilities = capabilities,
      on_attach = on_attach,
    })
    
    -- Haskell (haskell-language-server)
    register_server("hls", {
      cmd = { "haskell-language-server-wrapper", "--lsp" },
      filetypes = { "haskell", "lhaskell" },
      root_dir = root_pattern("hie.yaml", "stack.yaml", "cabal.project", ".git"),
      capabilities = capabilities,
      on_attach = on_attach,
    })
    
    -- Java (jdtls) —— 仅最小可用；复杂项目请用 nvim-jdtls
    register_server("jdtls", {
      cmd = { "jdtls" },
      filetypes = { "java" },
      root_dir = root_pattern("gradlew", "mvnw", ".git"),
      capabilities = capabilities,
      on_attach = on_attach,
    })
    
    -- Python：basedpyright > pyright > pylsp（三选一注册）
    local has_based = (vim.fn.executable("basedpyright-langserver") == 1) or (vim.fn.executable("basedpyright") == 1)
    local has_pyright = (vim.fn.executable("pyright-langserver") == 1) or (vim.fn.executable("pyright") == 1)
    
    if has_based then
      register_server("basedpyright", {
        cmd = (vim.fn.executable("basedpyright-langserver") == 1)
          and { "basedpyright-langserver", "--stdio" }
          or  { "basedpyright", "--stdio" },
        filetypes = { "python" },
        root_dir = root_pattern("pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git"),
        settings = {
          basedpyright = {
            analysis = {
              autoImportCompletions = true,
              typeCheckingMode = "standard",
              diagnosticMode = "openFilesOnly",
            },
          },
        },
        capabilities = capabilities,
        on_attach = on_attach,
      })
    elseif has_pyright then
      register_server("pyright", {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_dir = root_pattern("pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git"),
        settings = {
          pyright = { disableOrganizeImports = false },
          python = {
            analysis = {
              autoImportCompletions = true,
              typeCheckingMode = "basic",
              diagnosticMode = "openFilesOnly",
            },
          },
        },
        capabilities = capabilities,
        on_attach = on_attach,
      })
    elseif vim.fn.executable("pylsp") == 1 then
      register_server("pylsp", {
        cmd = { "pylsp" },
        filetypes = { "python" },
        root_dir = root_pattern(".git"),
        settings = {
          pylsp = {
            plugins = {
              pyflakes = { enabled = true },
              pycodestyle = { enabled = false },
              mccabe = { enabled = false },
              yapf = { enabled = false },
              pylint = { enabled = false },
              pylsp_mypy = { enabled = false },
            },
          },
        },
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end
    
    ----------------------------------------------------------------
    -- === 你的“个性化覆盖”区：按需传入 settings/cmd 等 ===
    ----------------------------------------------------------------
    local overrides = {
      -- 示例：lua_ls/hls 等有额外需求时写在这
      -- lua_ls = { settings = { Lua = { hint = { enable = true } } } },
    }
    
    -- 按服务器名执行 setup（会创建 FileType 自动启动）
    for name, mod in pairs(vim.lsp.config) do
      if type(mod) == "table" and type(mod.setup) == "function" then
        mod.setup(overrides[name])
      end
    end
    
    -- === 诊断样式 ===
    vim.diagnostic.config({
      virtual_text = { spacing = 2, prefix = "●" },
      float = { border = "rounded" },
      severity_sort = true,
    })
  '';
}
