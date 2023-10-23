---@type MappingsTable
local M = {}

-- <C> -> Ctrl
-- <leader> -> Space
-- <A> -> alt
-- <S> -> shift
-- <M> -> meta (cmd key on mac)
-- <D> -> super (windows key on windows)
-- <kPoint> -> Keypad Point (.)
-- <kEqual> -> Keypad Equal (=)
-- <kPlus> -> Keypad Plus (+)
-- <kMinus> -> Keypad Minus (-)

local function move_or_create_win(key)
  local fn = vim.fn
  local curr_win = fn.winnr()
  vim.cmd("wincmd " .. key) --> attempt to move

  if curr_win == fn.winnr() then --> didn't move, so create a split
    if key == "h" or key == "l" then
      vim.cmd "wincmd v"
    else
      vim.cmd "wincmd s"
    end

    vim.cmd("wincmd " .. key)
  end
end

M.disabled = {
  n = {
    ["<leader>b"] = "",
  },
}

M.rest = {
  n = {
    ["<leader>rs"] = {
      function()
        require("rest-nvim").run()
      end,
      "󰖟 RestNvim Run",
    },
  },
}

M.folder = {
  n = {
    ["<leader>a"] = {
      function()
        require("fold-cycle").toggle_all()
      end,
      "󰴋 Toggle folder",
    },
    ["<leader>p"] = {
      function()
        require("fold-preview").toggle_preview()
      end,
      "󱞊 Fold preview",
    },
  },
}

M.comment = {
  plugin = true,

  -- toggle comment in both modesx
  n = {
    ["<A-/>"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "  Toggle comment",
    },
    ["<D-/>"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "  Toggle comment",
    },
  },

  v = {
    ["<A-/>"] = {
      "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "  Toggle comment",
    },
  },
}

M.accelerated_jk = {
  n = {
    k = { "<Plug>(accelerated_jk_gk)", " Accelerated up movement" },
    j = { "<Plug>(accelerated_jk_gj)", " Accelerated down movement" },
  },
}

M.development = {
  n = {
    ["<leader>i"] = {
      function()
        require("nvim-toggler").toggle()
      end,
      "󰌁 Invert text",
    },
    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      " Lsp formatting",
    },
    ["<leader>bi"] = {
      function()
        require("nvim-biscuits").toggle_biscuits()
      end,
      "󰆘 Toggle context",
    },
    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "󰑊 Go to definition",
    },
    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "󰑊 Go to implementation",
    },
  },
}

M.split = {
  n = {
    ["<C-h>"] = {
      function()
        move_or_create_win "h"
      end,
      "[h]: Move to window on the left or create a split",
    },
    ["<C-j>"] = {
      function()
        move_or_create_win "j"
      end,
      "[j]: Move to window below or create a vertical split",
    },
    ["<C-k>"] = {
      function()
        move_or_create_win "k"
      end,
      "[k]: Move to window above or create a vertical split",
    },
    ["<C-l>"] = {
      function()
        move_or_create_win "l"
      end,
      "[l]: Move to window on the right or create a split",
    },
  },
}

M.text = {
  i = {
    -- Move line up and down
    ["<C-Up>"] = { "<CMD>m .-2<CR>==", "󰜸 Move line up" },
    ["<C-Down>"] = { "<CMD>m .+1<CR>==", "󰜯 Move line down" },

    -- Navigate
    ["<A-Left>"] = { "<ESC>I", " Move to beginning of line" },
    ["<A-Right>"] = { "<ESC>A", " Move to end of line" },
    ["<A-d>"] = { "<ESC>diw", " Delete word" },
    ["<S-CR>"] = {
      function()
        vim.cmd "normal o"
      end,
      " New line",
    },
  },

  n = {
    -- Navigate
    ["<C-Left>"] = { "<ESC>_", "󰜲 Move to beginning of line" },
    ["<C-Right>"] = { "<ESC>$", "󰜵 Move to end of line" },
    ["<C-a>"] = { "gg0vG", " Select all" },
    ["<F3>"] = { "n", " Next" },
    ["<S-F3>"] = { "N", " Previous" },
    -- Operations
    ["<C-z>"] = { "<CMD>u<CR>", "󰕌 Undo" },
    ["<C-r>"] = { "<CMD>redo<CR>", "󰑎 Redo" },
    ["<C-x>"] = { "x", "󰆐 Cut" },
    ["<C-v>"] = { "p", "󰆒 Paste" },
    ["<C-c>"] = { "y", " Copy" },
    ["p"] = { "p`[v`]=", "󰆒 Paste" },
    ["<leader><leader>d"] = { "viw", " Select word" },
    ["<leader>d"] = { 'viw"_di', " Delete word" },
    ["<C-Up>"] = { "<CMD>m .-2<CR>==", "󰜸 Move line up" },
    ["<C-Down>"] = { "<CMD>m .+1<CR>==", "󰜯 Move line down" },
    -- Renamer
    ["<C-R>"] = { "<CMD>:MurenToggle<CR>", "󱝪 Toggle Search" },
    ["<leader>sp"] = { "<CMD>:TSJToggle<CR>", "󰯌 Toggle split/join" },
    ["<A-d>"] = { "<CMD>:MCstart<CR>", "Multi cursor" },
    ["<leader>ra"] = {
      function()
        require("nvchad.renamer").open()
      end,
      "󰑕 LSP rename",
    },
    ["<leader>rn"] = {
      function()
        return ":IncRename " .. vim.fn.expand "<cword>"
      end,
      -- ":IncRename "
      "󰑕 Rename",
      opts = { expr = true },
    },
    -- Quit
    ["<Esc>"] = {
      function()
        vim.cmd "noh"
        vim.cmd "Noice dismiss"
      end,
      " Clear highlights",
      opts = { silent = true },
    },
  },

  v = {
    ["<C-Up>"] = { ":m'<-2<CR>gv=gv", "󰜸 Move selection up", opts = { silent = true } },
    ["<C-Down>"] = { ":m'>+1<CR>gv=gv", "󰜯 Move selection down", opts = { silent = true } },
    ["<Home>"] = { "gg", "Home" },
    ["<End>"] = { "G", "End" },
    ["y"] = { "y`]", "Yank and move to end" },
    -- Indent backward/forward:
    ["<"] = { "<gv", " Ident backward", opts = { silent = false } },
    [">"] = { ">gv", " Ident forward", opts = { silent = false } },

    ["<C-Left>"] = { "<ESC>_", "󰜲 Move to beginning of line" },
    ["<C-Right>"] = { "<ESC>$", "󰜵 Move to end of line" },
  },

  c = {
    -- Autocomplete for brackets:
    ["("] = { "()<left>", "Auto complete (", opts = { silent = false } },
    ["<"] = { "<><left>", "Auto complete <", opts = { silent = false } },
    ['"'] = { '""<left>', [[Auto complete "]], opts = { silent = false } },
    ["'"] = { "''<left>", "Auto complete '", opts = { silent = false } },
  },
}

M.go = {
  n = {
    ["<leader>fi"] = { " <CMD>:GoImport<CR>", " Format imports", opts = { silent = true } },
    ["<leader>gif"] = { " <CMD>:GoIfErr<CR>", " Create If Err", opts = { silent = true } },
    ["<leader>gfs"] = { " <CMD>:GoFillStruct<CR>", " Fill struct", opts = { silent = true } },
    ["<leader>gcv"] = { " <CMD>:GoCoverage -p<CR>", " Show coverage", opts = { silent = true } },
    ["<leader>gt"] = { " <CMD>:GoAlt!<CR>", " Go to test", opts = { silent = true } },
    ["<leader>gca"] = { " <CMD>:GoCodeAction<CR>", " Code action", opts = { silent = true } },
    ["<leader>cl"] = { " <CMD>:GoCodeLenAct<CR>", " Code Lens", opts = { silent = true } },
  },
}

M.window = {
  n = {
    ["<leader><leader>h"] = { "<CMD>vs <CR>", "󰤼 Vertical split", opts = { nowait = true } },
    ["<leader><leader>v"] = { "<CMD>sp <CR>", "󰤻 Horizontal split", opts = { nowait = true } },
  },
}

M.general = {
  n = {
    [";"] = {
      "<CMD>lua require('telescope.builtin').resume(require('telescope.themes').get_ivy({}))<CR>",
      "Resume telescope",
      opts = { nowait = true },
    },
    ["<leader>q"] = { "<CMD>q<CR>", "󰗼 Close" },
    ["<leader>qq"] = { "<CMD>qa!<CR>", "󰗼 Exit" },
    ["<A-p>"] = { "<CMD> Telescope commander<CR>", "󰘳 Find files" },
    ["<C-p>"] = {
      function()
        local entry_maker = require("custom.configs.entry").find_files_entry_maker
        local opts = {
          entry_maker = entry_maker(),
          sorting_strategy = "ascending",
          layout_strategy = "center",
          border = true,
          borderchars = {
            prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
            results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
            preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          },
          layout_config = {
            width = 0.8,
            height = 0.6,
          },
          results_title = false,
          previewer = false,
        }

        opts.show_untracked = true

        local succ = pcall(require("telescope.builtin").git_files, opts)

        if not succ then
          require("telescope.builtin").find_files(opts)
        end
      end,
      "󰘳 Find files",
    },

    -- Keep cursor in the center line when C-D / C-U
    ["<C-d>"] = { "<C-d>zz", " Scroll down", opts = { silent = true } },
    ["<C-u>"] = { "<C-u>zz", " Scroll up", opts = { silent = true } },

    ["<leader>cs"] = { "<CMD>SymbolsOutline<CR>", " Symbols Outline" },
    ["<leader>tr"] = {
      function()
        require("base46").toggle_transparency()
      end,
      "󰂵 Toggle transparency",
    },
    ["<leader>w"] = {
      function()
        require("nvchad.tabufline").close_buffer()
      end,
      " Close buffer",
    },
  },
}

M.diagnostics = {
  n = {
    ["<leader>t"] = { "<CMD>TroubleToggle<CR>", "󰔫 Toggle warnings" },
    ["<leader>td"] = { "<CMD>TodoTrouble keywords=TODO,FIX,FIXME,BUG,TEST,NOTE<CR>", " Todo/Fix/Fixme" },
    ["<leader>el"] = { "<CMD>ErrorLensToggle<CR>", "󱇭 Toggle error lens" },
    ["<leader>ft"] = { "<CMD>TodoTelescope<CR>", " Telescope TODO" },
    ["<Leader>ll"] = {
      function()
        require("lsp_lines").toggle()
      end,
      " Toggle lsp_lines",
    },
  },
}

M.node = {
  n = {
    ["<leader>ns"] = {
      function()
        require("package-info").show()
      end,
      "󰎙 Show package info",
    },
    ["<leader>up"] = {
      function()
        require("package-info").update()
      end,
      "󰎙 Update package",
    },
    ["<leader>nd"] = {
      function()
        require("package-info").delete()
      end,
      "󰎙 Delete package",
    },
    ["<leader>np"] = {
      function()
        require("package-info").change_version()
      end,
      "󰎙 Install package",
    },
    ["<leader>jc"] = {
      function()
        require("nvim-js-actions").js_arrow_fn.toggle()
      end,
      "󰎙 Toggle arrow",
    },
  },
}

M.treesitter = {
  n = {
    ["<leader>cu"] = { "<CMD>InspectTree <CR>", " Find highlight" },
    ["<leader>to"] = { "<CMD>TSJToggle<CR>", "󱓡 Toggle split/join" },
  },
}

M.debug = {
  n = {
    ["<leader>tt"] = { "<CMD>PBToggleBreakpoint<CR>", " Toggle breakpoint" },
    ["<F5>"] = { "<CMD>DapContinue <CR>", " Continue" },
    ["<F10>"] = { "<CMD>DapStepOver <CR>", " Step over" },
    ["<F11>"] = { "<CMD>DapStepInto <CR>", " Step into" },
    ["<F9>"] = { "<CMD>DapStepOut <CR>", " Step out" },
    ["<leader><leader>p"] = {
      function()
        require("debugprint").debugprint()
      end,
      " Step out",
    },
  },
}

M.git = {
  n = {
    ["<leader>gc"] = { "<CMD>Telescope git_commits<CR>", "  Git commits" },
    ["<leader>gb"] = { "<CMD>Telescope git_branches<CR>", "  Git branches" },
    ["<leader>gs"] = { "<CMD>Telescope git_status<CR>", "  Git status" },
    ["<leader>lg"] = { "<CMD>LazyGit<CR>", "  LazyGit" },
    ["<leader>gl"] = { "<CMD>GitBlameToggle<CR>", "  Blame line" },
    ["<leader>gtb"] = { "<CMD>ToggleBlame<CR>", "  Blame line" },
    ["<leader>gvd"] = { "<CMD> DiffviewOpen<CR>", "  Show git diff" },
    ["<leader>gvf"] = { "<CMD> DiffviewFileHistory %<CR>", "  Show file history" },
    ["<leader>gvp"] = { "<CMD> DiffviewOpen --cached<CR>", "  Show staged diffs" },
    ["<leader>gvr"] = { "<CMD> DiffviewRefresh<CR>", "  Refresh diff view" },
    ["<leader>gvc"] = { "<CMD> DiffviewClose<CR>", "  Close diff view" },
    ["<Leader>gcb"] = { "<CMD>GitConflictChooseBoth<CR>", "Choose both" },
    ["<Leader>gcn"] = { "<CMD>GitConflictNextConflict<CR>", "Move to next conflict" },
    ["<Leader>gco"] = { "<CMD>GitConflictChooseOurs<CR>", "Choose ours" },
    ["<Leader>gcp"] = { "<CMD>GitConflictPrevConflict<CR>", "Move to prev conflict" },
    ["<Leader>gct"] = { "<CMD>GitConflictChooseTheirs<CR>", "Choose theirs" },
  },
}

M.telescope = {
  n = {
    ["<leader>li"] = { "<CMD>Telescope highlights<CR>", "Highlights" },
    ["<leader>fk"] = { "<CMD>Telescope keymaps<CR>", " Find keymaps" },
    ["<leader>fs"] = { "<CMD>Telescope lsp_document_symbols<CR>", " Find document symbols" },
    ["<leader>fr"] = { "<CMD>Telescope frecency<CR>", " Recent files" },
    ["<leader>fu"] = { "<CMD>Telescope undo<CR>", " Undo tree" },
    ["<leader>fg"] = { "<CMD>Telescope ast_grep<CR>", " Structural Search" },
    ["<leader>fre"] = {
      function()
        require("telescope").extensions.refactoring.refactors()
      end,
      " Structural Search",
    },
    ["<leader>fz"] = {
      "<CMD>Telescope current_buffer_fuzzy_find fuzzy=false case_mode=ignore_case<CR>",
      " Find current file",
    },
    ["<leader>ff"] = {
      function()
        local builtin = require "telescope.builtin"
        -- ignore opened buffers if not in dashboard or directory
        if vim.fn.isdirectory(vim.fn.expand "%") == 1 or vim.bo.filetype == "alpha" then
          builtin.find_files()
        else
          local function literalize(str)
            return str:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", function(c)
              return "%" .. c
            end)
          end

          local function get_open_buffers()
            local buffers = {}
            local len = 0
            local vim_fn = vim.fn
            local buflisted = vim_fn.buflisted

            for buffer = 1, vim_fn.bufnr "$" do
              if buflisted(buffer) == 1 then
                len = len + 1
                -- get relative name of buffer without leading slash
                buffers[len] = "^"
                  .. literalize(string.gsub(vim.api.nvim_buf_get_name(buffer), literalize(vim.loop.cwd()), ""):sub(2))
                  .. "$"
              end
            end

            return buffers
          end

          builtin.find_files {
            file_ignore_patterns = get_open_buffers(),
          }
        end
      end,
      "Find files",
    },
  },
}

M.tabufline = {
  plugin = true,

  n = {
    -- cycle through buffers
    ["<tab>"] = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      " Goto next buffer",
    },

    ["<S-tab>"] = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      " Goto prev buffer",
    },

    -- close buffer + hide terminal buffer
    ["<C-x>"] = {
      function()
        require("nvchad.tabufline").close_buffer()
      end,
      " Close buffer",
    },

    -- close all buffers
    ["<leader>bx"] = {
      function()
        local current_buf = vim.api.nvim_get_current_buf()
        local all_bufs = vim.api.nvim_list_bufs()

        for _, buf in ipairs(all_bufs) do
          if buf ~= current_buf and vim.fn.getbufinfo(buf)[1].changed ~= 1 then
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end
      end,
      " Close all but current buffer",
    },
  },
}

M.docker = {
  n = {
    ["<leader>ld"] = { "<CMD> LazyDocker <CR>", "󰡨 Open LazyDocker" },
  },
}

M.test = {
  n = {
    ["<leader>nt"] = {
      function()
        require("neotest").run.run(vim.fn.expand "%")
      end,
      "󰤑 Run neotest",
    },
  },
}

M.nvimtree = {
  n = {
    ["<C-b>"] = { "<CMD> NvimTreeToggle <CR>", "󰔱 Toggle nvimtree" },
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
  },
  i = {
    ["<C-b>"] = { "<CMD> NvimTreeToggle <CR>", "󰔱 Toggle nvimtree" },
  },
}

M.session = {
  n = {
    ["<leader>ss"] = { "<CMD>Telescope persisted<CR>", "󰆓 List session" },
    ["<leader>sd"] = { "<CMD>SessionDelete<CR>", "󱙃 Delete Session" },
  },
}

M.hop = {
  n = {
    ["<leader><leader>w"] = { "<CMD> HopWord <CR>", "󰸱 Hint all words" },
    ["<leader><leader>t"] = { "<CMD> HopNodes <CR>", " Hint Tree" },
    ["<leader><leader>c"] = { "<CMD> HopLineStart<CR>", "󰕭 Hint Columns" },
    ["<leader><leader>l"] = { "<CMD> HopWordCurrentLine<CR>", "󰗉 Hint Line" },
  },
}

M.searchbox = {
  n = {
    ["<C-F>"] = { "<CMD> SearchBoxMatchAll clear_matches=true<CR>", "󱘟 Search matching all" },
    ["<A-R>"] = { "<CMD> SearchBoxReplace confirm=menu<CR>", " Replace" },
  },
}

M.bookmark = {
  n = {
    ["<leader>ba"] = { "<CMD> BookmarkToggle<CR>", "󰃅 Add bookmark" },
    ["<leader>bn"] = { "<CMD> BookmarkNext<CR>", "󰮰 Next bookmark" },
    ["<leader>bp"] = { "<CMD> BookmarkPrev<CR>", "󰮲 Prev bookmark" },
    ["<leader>bc"] = { "<CMD> BookmarkClear<CR>", "󰃢 Clear bookmark" },
    ["<leader>bm"] = { "<CMD>Telescope vim_bookmarks all<CR>", " Bookmark Menu" },
  },
}

M.lspsaga = {
  n = {
    ["<leader>."] = { "<CMD>CodeActionMenu<CR>", "󰅱 Code Action" },
    ["gf"] = {
      function()
        vim.cmd "Lspsaga lsp_finder"
      end,
      " Go to definition",
    },
    ["gt"] = {
      "<CMD>Lspsaga goto_definition<CR>",
      " Go to definition",
    },
    ["<leader>lp"] = {
      "<CMD>Lspsaga peek_definition<CR>",
      " Peek definition",
    },
    ["<leader>k"] = {
      -- "<CMD>Lspsaga hover_doc<CR>",
      function()
        require("pretty_hover").hover()
      end,
      "󱙼 Hover lsp",
    },
    ["<leader>o"] = { "<CMD>Lspsaga outline<CR>", " Show Outline" },
    --  LSP
    ["gr"] = { "<CMD>Telescope lsp_references<CR>", " Lsp references" },
    ["[d"] = { "<CMD>Lspsaga diagnostic_jump_prev<CR>", " Prev Diagnostic" },
    ["]d"] = { "<CMD>Lspsaga diagnostic_jump_next<CR>", " Next Diagnostic" },
    ["<leader>qf"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "󰁨 Lsp Quickfix",
    },
  },
}

M.nvterm = {
  t = {
    -- toggle in terminal mode
    ["<leader>h"] = {
      function()
        require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm", size = 0.2 }
      end,
      " Toggle horizontal term",
    },
    ["C-c"] = { [[<C-\><C-c>]], "󰜺 Send SigInt" },
  },

  n = {
    -- toggle in normal mode
    ["<leader>h"] = {
      function()
        require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm", size = 0.2 }
      end,
      " Toggle horizontal term",
    },
  },
}

M.portal = {
  n = {
    ["<leader>pj"] = { "<CMD>Portal jumplist backward<CR>", "󱡁 Portal Jumplist" },
    ["<leader>ph"] = {
      function()
        require("portal.builtin").harpoon.tunnel()
      end,
      "󱡁 Portal Harpoon",
    },
  },
}

M.harpoon = {
  n = {
    ["<leader>ha"] = {
      function()
        require("harpoon.mark").add_file()
      end,
      "󱡁 Harpoon Add file",
    },
    ["<leader>ta"] = { "<CMD>Telescope harpoon marks<CR>", "󱡀 Toggle quick menu" },
    ["<leader>hb"] = {
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      "󱠿 Harpoon Menu",
    },
    ["<leader>1"] = {
      function()
        require("harpoon.ui").nav_file(1)
      end,
      "󱪼 Navigate to file 1",
    },
    ["<leader>2"] = {
      function()
        require("harpoon.ui").nav_file(2)
      end,
      "󱪽 Navigate to file 2",
    },
    ["<leader>3"] = {
      function()
        require("harpoon.ui").nav_file(3)
      end,
      "󱪾 Navigate to file 3",
    },
    ["<leader>4"] = {
      function()
        require("harpoon.ui").nav_file(4)
      end,
      "󱪿 Navigate to file 4",
    },
  },
}

M.lspconfig = {
  n = {
    ["<leader><leader>n"] = { "<CMD> lua require('tsht').nodes() <CR>", " Select Node" },
    ["<F12>"] = { "<CMD>Glance references<CR>", "󰘐 References" },
  },
}

return M
