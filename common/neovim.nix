{ config, pkgs, ... }:

{
  programs.nixvim = let
    helpers = config.lib.nixvim;
  in {
    enable = true;

    defaultEditor = true;
    enableMan = true;

    colorschemes.modus.enable = true;

    viAlias = true;
    vimAlias = true;

    globals = {
      mapleader = " ";
      maplocalleader = "\\";
      autoformat = true;
    };

    opts = {
      autowrite = true;
      clipboard = "unnamedplus";
      completeopt = "menu,menuone,noselect";
      conceallevel = 2;
      confirm = true;
      cursorline = true;
      expandtab = true;
      fillchars = {
        diff = "╱";
        eob = " ";
        fold = " ";
        foldclose = "";
        foldopen = "";
        foldsep = " ";
      };
      foldlevel = 99;
      foldtext = "";
      formatoptions = "jcroqlnt";
      grepformat = "%f:%l:%c:%m";
      grepprg = "${pkgs.ripgrep}/bin/rg --vimgrep";
      ignorecase = true;
      inccommand = "nosplit";
      jumpoptions = "view";
      laststatus = 3;
      linebreak = true;
      list = true;
      mouse = "a";
      number = true;
      pumblend = 10;
      pumheight = 10;
      relativenumber = true;
      scrolloff = 4;
      sessionoptions = [ "buffers" "curdir" "tabpages" "winsize" "help" "globals" "skiprtp" "folds" ];
      shiftround = true;
      shiftwidth = 2;
      shortmess = "ltToOCFWIcC";
      showmode = false;
      sidescrolloff = 8;
      signcolumn = "yes";
      smartcase = true;
      smartindent = true;
      smoothscroll = true;
      spelllang = [ "en" ];
      spelloptions = [ "noplainbuffer" ];
      splitbelow = true;
      splitkeep = "screen";
      splitright = true;
      # FIXME: try to reverse engineer this
      # statuscolumn = [[%!v:lua.require'lazyvim.util'.ui.statuscolumn()]];
      tabstop = 2;
      termguicolors = true;
      timeoutlen = 300;
      undofile = true;
      undolevels = 10000;
      updatetime = 200;
      virtualedit = "block";
      wildmode = "longest:full,full";
      winminwidth = 5;
      wrap = false;
    };

    autoCmd = [
      {
        desc = "Reload file when changed";
        event = [
          "FocusGained"
          "TermClose"
          "TermLeave"
        ];
        callback = helpers.mkRaw ''
          function()
            if vim.o.buftype ~= "nofile" then
              vim.cmd("checktime")
            end
          end
        '';
      }
      {
        desc = "Highlight on yank";
        event = [
          "TextYankPost"
        ];
        callback = helpers.mkRaw ''
          function()
            vim.highlight.on_yank()
          end
        '';
      }
      {
        desc = "Resize splits when window is resized";
        event = [
          "VimResized"
        ];
        callback = helpers.mkRaw ''
          function()
            local current_tab = vim.fn.tabpagenr()
            vim.cmd("tabdo wincmd =")
            vim.cmd("tabnext " .. current_tab)
          end
        '';
      }
      {
        desc = "Go to last location when opening a buffer";
        event = [
          "BufReadPost"
        ];
        callback = helpers.mkRaw ''
          function(event)
            local exclude = { "gitcommit" }
            local buf = event.buf
            if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_location then
              return
            end
            vim.b[buf].last_location = true
            local mark = vim.api.nvim_buf_get_mark(buf, '"')
            local lcount = vim.api.nvim_buf_line_count(buf)
            if mark[1] > 0 and mark[1] <= lcount then
              pcall(vim.api.nvim_win_set_cursor, 0, mark)
            end
          end
        '';
      }
      {
        desc = "Wrap and spellcheck text";
        event = [
          "FileType"
        ];
        pattern = [
          "text"
          "plaintex"
          "typst"
          "gitcommit"
          "markdown"
        ];
        callback = helpers.mkRaw ''
          function()
            vim.opt_local.wrap = true
            vim.opt_local.spell = true
          end
        '';
      }
      {
        desc = "Fix conceallevel for JSON";
        event = [
          "FileType"
        ];
        pattern = [
          "json"
          "jsonc"
          "json5"
        ];
        callback = helpers.mkRaw ''
          function()
            vim.opt_local.conceallevel = 0
          end
        '';
      }
      {
        desc = "Create missing intermediate directories on file creation";
        event = [
          "BufWritePre"
        ];
        callback = helpers.mkRaw ''
          function(event)
            if event.match:match("^%w%w+:[\\/][\\/]") then
              return
            end
            local file = vim.uv.fs_realpath(event.match) or event.match
            vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
          end
        '';
      }
    ];


    plugins = {
      lsp = {
        enable = true;
        keymaps = {
          extra = [
            { key = "<Leader>cl"; action = "<Cmd>LspInfo<CR>"; }
          ];

          lspBuf = {
            K = "hover";
            gd = "definition";
            gD = "references";
            gi = "implementation";
            gt = "type_definition";
            gK = "signature_help";
            "<Leader>ca" = "code_action";
          };
        };
        servers = {
          clojure_lsp.enable = true;
          gopls.enable = true;
          nil_ls.enable = true;
          ruby_lsp.enable = true;
          zls.enable = true;
        };
      };

      conform-nvim = {
        enable = true;
        settings = {
          default_format_opts = {
            timeout_ms = 3000;
            async = false;
            quiet = false;
            lsp_format = "fallback";
          };
          formatters_by_ft = {
            sh = [ "${pkgs.shfmt}/bin/shfmt" ];
          };
          formatters.injected.options.ignore_errors = true;
        };
      };

      conjure.enable = true;

      neotest = {
        enable = true;
        adapters = {
          golang.enable = true;
          java.enable = true;
          jest.enable = true;
          rspec.enable = true;
          minitest.enable = true;
          zig.enable = true;
        };
      };

      telescope = {
        enable = true;
        extensions.fzf-native.enable = true;
        keymaps = {
          "<Leader>," = {
            action = "buffers sort_mru=true sort_lastused=true";
            options.desc = "Switch Buffer";
          };
          "<Leader>/" = {
            action = "live_grep";
            options.desc = "Grep (Root Dir)";
          };
          "<Leader>:" = {
            action = "command_history";
            options.desc = "Command History";
          };
          "<Leader><Space>" = {
            action = "find_files";
            options.desc = "Find Files (Root Dir)";
          };
          "<Leader>fb" = {
            action = "buffers sort_mru=true sort_lastused=true";
            options.desc = "Buffers";
          };
          "<Leader>fc" = {
            action = "config_files";
            options.desc = "Find Config File";
          };
          "<Leader>ff" = {
            action = "files";
            options.desc = "Find Files (Root Dir)";
          };
          "<Leader>fF" = {
            action = "files root = false";
            options.desc = "Find Files (cwd)";
          };
          "<Leader>fg" = {
            action = "git_files";
            options.desc = "Find Files (git-files)";
          };
          "<Leader>fr" = {
            action = "oldfiles";
            options.desc = "Recent";
          };
          "<Leader>fR" = {
            action = "oldfiles cwd = vim.uv.cwd()";
            options.desc = "Recent (cwd)";
          };
          "<Leader>gc" = {
            action = "git_commits";
            options.desc = "Commits";
          };
          "<Leader>gs" = {
            action = "git_status";
            options.desc = "Status";
          };
          "<Leader>s\"" = {
            action = "registers";
            options.desc = "Registers";
          };
          "<Leader>sa" = {
            action = "autocommands";
            options.desc = "Auto Commands";
          };
          "<Leader>sb" = {
            action = "current_buffer_fuzzy_find";
            options.desc = "Buffer";
          };
          "<Leader>sc" = {
            action = "command_history";
            options.desc = "Command History";
          };
          "<Leader>sC" = {
            action = "commands";
            options.desc = "Commands";
          };
          "<Leader>sd" = {
            action = "diagnostics bufnr=0";
            options.desc = "Document Diagnostics";
          };
          "<Leader>sD" = {
            action = "diagnostics";
            options.desc = "Workspace Diagnostics";
          };
          "<Leader>sg" = {
            action = "live_grep";
            options.desc = "Grep (Root Dir)";
          };
          "<Leader>sG" = {
            action = "live_grep root = false";
            options.desc = "Grep (cwd)";
          };
          "<Leader>sh" = {
            action = "help_tags";
            options.desc = "Help Pages";
          };
          "<Leader>sH" = {
            action = "highlights";
            options.desc = "Search Highlight Groups";
          };
          "<Leader>sj" = {
            action = "jumplist";
            options.desc = "Jumplist";
          };
          "<Leader>sk" = {
            action = "keymaps";
            options.desc = "Key Maps";
          };
          "<Leader>sl" = {
            action = "loclist";
            options.desc = "Location List";
          };
          "<Leader>sM" = {
            action = "man_pages";
            options.desc = "Man Pages";
          };
          "<Leader>sm" = {
            action = "marks";
            options.desc = "Jump to Mark";
          };
          "<Leader>so" = {
            action = "vim_options";
            options.desc = "Options";
          };
          "<Leader>sR" = {
            action = "resume";
            options.desc = "Resume";
          };
          "<Leader>sq" = {
            action = "quickfix";
            options.desc = "Quickfix List";
          };
          "<Leader>sw" = {
            action = "grep_string word_match = \"-w\"";
            options.desc = "Word (Root Dir)";
          };
          "<Leader>sW" = {
            action = "grep_string root = false word_match = \"-w\"";
            options.desc = "Word (cwd)";
          };
          "<Leader>uC" = {
            action = "colorscheme enable_preview = true";
            options.desc = "Colorscheme with Preview";
          };
          "<Leader>ss" = {
            action = "function() require('telescope.builtin').lsp_document_symbols({ symbols = LazyVim.config.get_kind_filter() }) end";
            options.desc = "Goto Symbol";
          };
          "<Leader>sS" = {
            action = "function() require('telescope.builtin').lsp_dynamic_workspace_symbols({ symbols = LazyVim.config.get_kind_filter() }) end";
            options.desc = "Goto Symbol (Workspace)";
          };
        };

        settings = {
          defaults = {
            prompt_prefix = " ";
            selection_caret = " ";
          };
          mappings = {
            i = {
              # "<c-t>" = "open_with_trouble",
              # "<a-t>" = "open_with_trouble",
              # "<a-i>" = "find_files_no_ignore",
              # "<a-h>" = "find_files_with_hidden",
              "<C-Down>" = "actions.cycle_history_next";
              "<C-Up>" = "actions.cycle_history_prev";
              "<C-f>" = "actions.preview_scrolling_down";
              "<C-b>" = "actions.preview_scrolling_up";
            };
            n.q = "actions.close";
          };
          pickers.find_files = {
            find_command = [ "${pkgs.ripgrep}/bin/rg" "--files" "--color" "never" "-g" "!.git" ];
            hidden = true;
          };
        };
      };

      treesitter = {
        enable = true;
        folding = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
          incremental_selection = {
            enable = true;
            keymaps = {
              init_selection = "<C-Space>";
              node_incremental = "<C-Space>";
              scope_incremental = false;
              node_decremental = "<BS>";
            };
          };
        };
      };

      treesitter-textobjects = {
        enable = true;
        move = {
          enable = true;
          gotoNextStart = {
            "]f" = "@function.outer";
            "]c" = "@class.outer";
            "]a" = "@parameter.inner";
          };
          gotoNextEnd = {
            "]F" = "@function.outer";
            "]C" = "@class.outer";
            "]A" = "@parameter.inner";
          };
          gotoPreviousStart = {
            "[f" = "@function.outer";
            "[c" = "@class.outer";
            "[a" = "@parameter.inner";
          };
          gotoPreviousEnd = {
            "[F" = "@function.outer";
            "[C" = "@class.outer";
            "[A" = "@parameter.inner";
          };
        };
      };

      ts-autotag.enable = true;

      web-devicons.enable = true;
      which-key.enable = true;

      oil.enable = true;
    };

    keymaps = [
      { key = "-"; mode = "n"; action = "<Cmd>Oil<CR>"; options.desc = "Open Parent Directory"; }

      { key = "j"; mode = [ "n" "x" ]; action = "v:count == 0 ? 'gj' : 'j'"; options = { desc = "Down"; expr = true; silent = true; }; }
      { key = "<Down>"; mode = [ "n" "x" ]; action = "v:count == 0 ? 'gj' : 'j'"; options = { desc = "Down"; expr = true; silent = true; }; }
      { key = "k"; mode = [ "n" "x" ]; action = "v:count == 0 ? 'gk' : 'k'"; options = { desc = "Up"; expr = true; silent = true; }; }
      { key = "<Up>"; mode = [ "n" "x" ]; action = "v:count == 0 ? 'gk' : 'k'"; options = { desc = "Up"; expr = true; silent = true; }; }

      { key = "<C-h>"; mode = "n"; action = "<C-w>h"; options = { desc = "Go to Left Window"; remap = true; }; }
      { key = "<C-j>"; mode = "n"; action = "<C-w>j"; options = { desc = "Go to Lower Window"; remap = true; }; }
      { key = "<C-k>"; mode = "n"; action = "<C-w>k"; options = { desc = "Go to Upper Window"; remap = true; }; }
      { key = "<C-l>"; mode = "n"; action = "<C-w>l"; options = { desc = "Go to Right Window"; remap = true; }; }

      { key = "<C-Up>"; mode = "n"; action = "<Cmd>resize +2<CR>"; options.desc = "Increase Window Height"; }
      { key = "<C-Down>"; mode = "n"; action = "<Cmd>resize -2<CR>"; options.desc = "Decrease Window Height"; }
      { key = "<C-Left>"; mode = "n"; action = "<Cmd>vertical resize -2<CR>"; options.desc = "Decrease Window Width"; }
      { key = "<C-Right>"; mode = "n"; action = "<Cmd>vertical resize +2<CR>"; options.desc = "Increase Window Width"; }

      { key = "<A-j>"; mode = "n"; action = "<Cmd>m .+1<CR>=="; options.desc = "Move Down"; }
      { key = "<A-k>"; mode = "n"; action = "<Cmd>m .-2<CR>=="; options.desc = "Move Up"; }
      { key = "<A-j>"; mode = "i"; action = "<Esc><Cmd>m .+1<CR>==gi"; options.desc = "Move Down"; }
      { key = "<A-k>"; mode = "i"; action = "<Esc><Cmd>m .-2<CR>==gi"; options.desc = "Move Up"; }
      { key = "<A-j>"; mode = "v"; action = "<Cmd>m '>+1<CR>gv=gv"; options.desc = "Move Down"; }
      { key = "<A-k>"; mode = "v"; action = "<Cmd>m '<-2<CR>gv=gv"; options.desc = "Move Up"; }

      { key = "<S-h>"; mode = "n"; action = "<Cmd>bprevious<CR>"; options.desc = "Prev Buffer"; }
      { key = "<S-l>"; mode = "n"; action = "<Cmd>bnext<CR>"; options.desc = "Next Buffer"; }
      { key = "[b"; mode = "n"; action = "<Cmd>bprevious<CR>"; options.desc = "Prev Buffer"; }
      { key = "]b"; mode = "n"; action = "<Cmd>bnext<CR>"; options.desc = "Next Buffer"; }
      { key = "<Leader>bb"; mode = "n"; action = "<Cmd>e #<CR>"; options.desc = "Switch to Other Buffer"; }
      { key = "<Leader>`"; mode = "n"; action = "<Cmd>e #<CR>"; options.desc = "Switch to Other Buffer"; }
      { key = "<Leader>bd"; mode = "n"; action = "<Cmd>:bd<CR>"; options.desc = "Delete Buffer"; }
      { key = "<Leader>bD"; mode = "n"; action = "<Cmd>:bd<CR>"; options.desc = "Delete Buffer"; }

      { key = "<esc>"; mode = ["i" "n"]; action = "<Cmd>noh<CR><esc>"; options.desc = "Escape and Clear hlsearch"; }

      { key = "<Leader>ur"; mode = "n"; action = "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>"; options.desc = "Redraw / Clear hlsearch / Diff Update"; }

      { key = "n"; mode = "n"; action = "'Nn'[v:searchforward].'zv'"; options = { expr = true; desc = "Next Search Result"; }; }
      { key = "n"; mode = "x"; action = "'Nn'[v:searchforward]"; options = { expr = true; desc = "Next Search Result"; }; }
      { key = "n"; mode = "o"; action = "'Nn'[v:searchforward]"; options = { expr = true; desc = "Next Search Result"; }; }
      { key = "N"; mode = "n"; action = "'nN'[v:searchforward].'zv'"; options = { expr = true; desc = "Prev Search Result"; }; }
      { key = "N"; mode = "x"; action = "'nN'[v:searchforward]"; options = { expr = true; desc = "Prev Search Result"; }; }
      { key = "N"; mode = "o"; action = "'nN'[v:searchforward]"; options = { expr = true; desc = "Prev Search Result"; }; }

      # From plugins/formatting.lua
      {
        key = "<Leader>cF";
        mode = ["n" "v"];
        action = helpers.mkRaw ''
          function()
            require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
          end
        '';
        options.desc = "Format Injected Langs";
      }

      # From keymaps.lua
      {
        key = "<Leader>qq";
        mode = "n";
        action = "<Cmd>qa<CR>";
        options.desc = "Quit All";
      }
      {
        key = "<Leader>tw";
        mode = "n";
        action = helpers.mkRaw ''
          function()
            require("neotest").watch.toggle(vim.fn.expand("%"))
          end
        '';
        options.desc = "Toggle Watch";
      }
      {
        key = "<Leader>tS";
        mode = "n";
        action = helpers.mkRaw ''
          function()
            require("neotest").run.stop()
          end
        '';
        options.desc = "Stop";
      }
      {
        key = "<Leader>tO";
        mode = "n";
        action = helpers.mkRaw ''
          function()
            require("neotest").output_panel.toggle()
          end
        '';
        options.desc = "Toggle Output Panel";
      }
      {
        key = "<Leader>to";
        mode = "n";
        action = helpers.mkRaw ''
          function()
            require("neotest").output.open({ enter = true, auto_close = true })
          end
        '';
        options.desc = "Show Output";
      }
      {
        key = "<Leader>ts";
        mode = "n";
        action = helpers.mkRaw ''
          function()
            require("neotest").summary.toggle()
          end
        '';
        options.desc = "Toggle Summary";
      }
      {
        key = "<Leader>tt";
        mode = "n";
        action = helpers.mkRaw ''
          function()
            require("neotest").run.run(vim.fn.expand("%"))
          end
        '';
        options.desc = "Run File";
      }
      {
        key = "<Leader>tT";
        mode = "n";
        action = helpers.mkRaw ''
          function()
            require("neotest").run.run(vim.uv.cwd())
          end
        '';
        options.desc = "Run All Test Files";
      }
      {
        key = "<Leader>tr";
        mode = "n";
        action = helpers.mkRaw ''
          function()
            require("neotest").run.run()
          end
        '';
        options.desc = "Run Nearest";
      }
      {
        key = "<Leader>tl";
        mode = "n";
        action = helpers.mkRaw ''
          function()
            require("neotest").run.run_last()
          end
        '';
        options.desc = "Run Last";
      }
    ];
  };
}
