{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    globals = {
      autoformat = true;
      mapleader = " ";
      maplocalleader = "\\";
      timeoutlen = 200;
    };
    opts = {
      autowrite = true;
      clipboard = "unnamedplus";
      completeopt = "menu,menuone,noselect";
      conceallevel = 2;
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
      copilot-lua.enable = true;
      fugitive.enable = true;
      gitsigns.enable = true;
      lualine.enable = true;
      lsp.enable = true;
      mini = {
        enable = true;
        modules = {
          comment.options.customCommentString = ''
            <cmd>lua require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring<cr>
          '';
          pairs = { };
          surround = { };
        };
      };
      nix.enable = true;
      telescope = {
        enable = true;
        extensions.fzf-native.enable = true;
      };
      treesitter = {
        enable = true;
        incrementalSelection.enable = true;
      };
      treesitter-context.enable = true;
      treesitter-textobjects.enable = true;
      ts-autotag.enable = true;
      ts-context-commentstring.enable = true;
      which-key.enable = true;
    };
    extraPlugins = with pkgs.vimPlugins; [ vim-rhubarb ];
    colorschemes.gruvbox.enable = true;
    keymaps = [
      {
        action = "<cmd>Telescope buffers sort_mru=tru sort_lastused=true<cr>";
        key = "<Leader>bb";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Switch buffer";
      }
      {
        action = "<cmd>Telescope command_history<cr>";
        key = "<Leader>:";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Command history";
      }
      {
        action = "<cmd>Telescope resume<cr>";
        key = "<Leader>'";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Continue last telescope";
      }
      {
        action = "<cmd>Telescope live_grep<cr>";
        key = "<Leader>/";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Live grep";
      }
      {
        action = "<cmd>Telescope find_files<cr>";
        key = "<Leader><space>";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Find files";
      }
      {
        action = "<cmd>Telescope find_files cwd=false<cr>";
        key = "<Leader>ff";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Find files in current directory";
      }
      {
        action = "<cmd>Telescope man_pages<cr>";
        key = "<Leader>hm";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Man pages";
      }
      {
        action = "<cmd>Telescope git_commits<cr>";
        key = "<Leader>gc";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Git commits";
      }
      {
        action = "<cmd>Telescope git_status<cr>";
        key = "<Leader>gs";
        mode = [
          "n"
          "v"
        ];
        options.desc = "Git status";
      }
    ];
  };
}
