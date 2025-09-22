{
  pkgs,
  ...
}:
{
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.monaspace
    nerd-fonts.victor-mono
  ];
}

