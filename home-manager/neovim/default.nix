{
  pkgs,
  lib,
  ...
}:
{
  programs.git.ignores = [
    "*.swp"
    "*.swo"
    "*.swn"
    ".*.swp"
    ".*.swo"
    ".*.swn"
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withRuby = true; # Needed for Ruby LSP and debugging
    withNodeJs = true; # Needed for various plugins
    withPython3 = true; # Needed for some plugins

    # LSPs and development tools
    extraPackages = with pkgs; [
      # Language servers
      lua-language-server
      nil # Nix LSP
      marksman # Markdown LSP
      typescript-language-server
      nodePackages.vscode-langservers-extracted # HTML/CSS/JSON LSP
      rubyPackages.solargraph # Alternative Ruby LSP

      # Formatters and linters
      stylua
      nixfmt-rfc-style
      prettierd
      nodePackages.eslint_d # Fast ESLint daemon for TypeScript/JavaScript linting

      # Development tools
      git
      gh # GitHub CLI
      ripgrep
      fd
      fzf
      lazygit

      # Ruby development
      ruby
      # rubyPackages.rdbg # Ruby debugger - not available in nixpkgs yet
      # TODO: rdbg is the new Ruby 3.1+ debugger, needs to be packaged for nix
      rubyPackages.byebug # Alternative Ruby debugger

      # Build tools for telescope-fzf-native
      gcc
      gnumake
    ];

    # LazyVim requires plugins to be loaded via lazy.nvim
    # So we just provide the base configuration
    extraLuaConfig = builtins.readFile ./init.lua;
  };

  # Link the lua configuration directory
  xdg.configFile."nvim/lua" = {
    source = ./lua;
    recursive = true;
  };

  # Copy lazy-lock.json from personal config to maintain plugin versions
  xdg.configFile."nvim/lazy-lock.json" = {
    source = /Users/jbutler/dotfiles/personal/config/nvim/lazy-lock.json;
  };

  # Copy other config files
  xdg.configFile."nvim/stylua.toml" = {
    source = /Users/jbutler/dotfiles/personal/config/nvim/stylua.toml;
  };

  xdg.configFile."nvim/.neoconf.json" = {
    source = /Users/jbutler/dotfiles/personal/config/nvim/.neoconf.json;
  };
}