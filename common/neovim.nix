{ ... }:

{
  programs.nixvim = {
    colorschemes.modus.enable = true;
    enable = true;
    defaultEditor = true;
    globals = {
      autoformat = true;
      mapleader = " ";
      maplocalleader = "\\";
      timeoutlen = 200;
    };
    keymaps = [
      {
        action.__raw = "function() require(\"neotest\").run.run(vim.fn.expand(\"%\")) end";
        key = "<Leader>tt";
        options.desc = "Run File";
      }
      {
        action.__raw = "function() require(\"neotest\").run.run(vim.uv.cwd()) end";
        key = "<Leader>tT";
        options.desc = "Run All Test Files";
      }
      {
        action.__raw = "function() require(\"neotest\").run.run() end";
        key = "<Leader>tr";
        options.desc = "Run Nearest";
      }
      {
        action.__raw = "function() require(\"neotest\").run.run_last() end";
        key = "<Leader>tl";
        options.desc = "Run Last";
      }
      {
        action.__raw = "function() require(\"neotest\").summary.toggle() end";
        key = "<Leader>ts";
        options.desc = "Toggle Summary";
      }
      {
        action.__raw = "function() require(\"neotest\").output.open({ enter = true, auto_close = true }) end";
        key = "<Leader>to";
        options.desc = "Show Output";
      }
      {
        action.__raw = "function() require(\"neotest\").output_panel.toggle() end";
        key = "<Leader>tO";
        options.desc = "Toggle Output Panel";
      }
      {
        action.__raw = "function() require(\"neotest\").run.stop() end";
        key = "<Leader>tS";
        options.desc = "Stop";
      }
      {
        action = "<Cmd>Oil<CR>";
        key = "-";
        mode = [ "n" ];
        options.desc = "Open parent directory in file browser";
      }
      {
        action = "<Cmd>Git<CR>";
        key = "<Leader>gg";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Open Neogit status buffer";
      }
      {
        action = "<Cmd>Telescope buffers sort_mru=tru sort_lastused=true<CR>";
        key = "<Leader>bb";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Switch buffer";
      }
      {
        action = "<Cmd>Telescope command_history<CR>";
        key = "<Leader>:";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Command history";
      }
      {
        action = "<Cmd>Telescope resume<CR>";
        key = "<Leader>'";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Continue last telescope";
      }
      {
        action = "<Cmd>Telescope live_grep<CR>";
        key = "<Leader>/";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Live grep";
      }
      {
        action = "<Cmd>Telescope find_files<CR>";
        key = "<Leader><space>";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Find files";
      }
      {
        action = "<Cmd>Telescope find_files cwd=false<CR>";
        key = "<Leader>ff";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Find files in current directory";
      }
      {
        action = "<Cmd>Telescope man_pages<CR>";
        key = "<Leader>hm";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Man pages";
      }
      {
        action = "<Cmd>Telescope git_commits<CR>";
        key = "<Leader>gc";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Git commits";
      }
      {
        action = "<Cmd>Telescope git_status<CR>";
        key = "<Leader>gs";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Git status";
      }
      {
        action = "<Cmd>close<CR>";
        key = "<Leader>wd";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Close window";
      }
      {
        action = "<Cmd>split<CR>";
        key = "<Leader>ws";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Split down";
      }
      {
        action = "<Cmd>vsplit<CR>";
        key = "<Leader>wv";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Split right";
      }
      {
        action = "<Cmd>wincmd j<CR>";
        key = "<Leader>wj";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Move cursor to window below";
      }
      {
        action = "<Cmd>wincmd k<CR>";
        key = "<Leader>wk";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Move cursor to window above";
      }
      {
        action = "<Cmd>wincmd h<CR>";
        key = "<Leader>wh";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Move cursor to window left";
      }
      {
        action = "<Cmd>wincmd l<CR>";
        key = "<Leader>wl";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Move cursor to window right";
      }
      {
        action = "<Cmd>term<CR>";
        key = "<Leader>oT";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Open terminal";
      }
    ];
    opts = {
      autowrite = true;
      background = "light";
      clipboard = "unnamedplus";
      completeopt = "menu,menuone,noselect";
      expandtab = true;
      formatoptions = "tcroqnlj";
      grepformat = "%f:%l:%c:%m";
      grepprg = "rg --vimgrep";
      ignorecase = true;
      laststatus = 3;
      number = true;
      relativenumber = true;
      scrolloff = 4;
      shiftround = true;
      shiftwidth = 2;
      showmode = false;
      sidescrolloff = 9;
      signcolumn = "yes";
      smartcase = true;
      tabstop = 2;
      undofile = true;
      undolevels = 10000;
      updatetime = 200;
      wildmode = "longest:full,full";
      winminwidth = 5;
      wrap = false;
    };
    plugins = {
      cmp.enable = true;
      cmp-buffer.enable = true;
      cmp-git.enable = true;
      cmp-path.enable = true;
      cmp-nvim-lsp.enable = true;
      conjure.enable = true;
      copilot-vim.enable = true;
      direnv.enable = true;
      fugitive.enable = true;
      lsp = {
        enable = true;
        servers = {
          clojure-lsp.enable = true;
          eslint.enable = true;
          gopls.enable = true;
          graphql.enable = true;
          kotlin-language-server.enable = true;
          nixd.enable = true;
          tsserver.enable = true;
          # zls.enable = true; FIXME when https://github.com/NixOS/nixpkgs/issues/317055 is fixed
        };
        keymaps = {
          extra = [
            {
              mode = "n";
              key = "gd";
              action.__raw = "function() require(\"telescope.builtin\").lsp_definitions({ reuse_win = true }) end";
              options.desc = "Goto definition";
            }
            {
              mode = "n";
              key = "gI";
              action.__raw = "function() require(\"telescope.builtin\").lsp_implementations({ reuse_win = true }) end";
              options.desc = "Goto implementation";
            }
            {
              key = "gy";
              mode = "n";
              action.__raw = "function() require(\"telescope.builtin\").lsp_type_definitions({ reuse_win = true }) end";
              options.desc = "Goto type definition";
            }
            {
              key = "<Leader>cl";
              mode = "n";
              action = "<Cmd>LspInfo<CR>";
              options.desc = "Show LSP information";
            }
            {
              key = "gr";
              mode = "n";
              action = "<Cmd>Telescope lsp_references<CR>";
              options.desc = "References";
            }
          ];
          lspBuf = {
            "gD" = {
              action = "declaration";
              desc = "Goto declaration";
            };
            "K" = {
              action = "hover";
              desc = "Hover";
            };
            "gK" = {
              action = "signature_help";
              desc = "Signature help";
            };
            "<C-k>" = {
              action = "signature_help";
              desc = "Signature help";
            };
            "<Leader>ca" = {
              action = "code_action";
              desc = "Code action";
            };
            "<Leader>cr" = {
              action = "rename";
              desc = "Rename";
            };
          };
        };
      };
      lsp-lines.enable = true;
      lualine.enable = true;
      luasnip.enable = true;
      mini = {
        enable = true;
        modules = {
          diff = { };
        };
      };
      neogit.enable = true;
      neotest = {
        enable = false;
        adapters = {
          go.enable = true;
          jest.enable = true;
          minitest.enable = true;
          rspec.enable = true;
        };
        settings = {
          output.open_on_run = true;
          status.virtual_text = true;
        };
      };
      nix.enable = true;
      oil.enable = true;
      parinfer-rust.enable = true;
      surround.enable = true;
      telescope = {
        enable = true;
        extensions.fzf-native.enable = true;
      };
      treesitter = {
        enable = true;
        incrementalSelection.enable = true;
        indent = true;
        nixvimInjections = true;
      };
      treesitter-textobjects.enable = true;
      trim.enable = true;
      which-key.enable = true;
    };
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
