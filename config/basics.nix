{
  lib,
  pkgs,
  ...
}: {
  # colorscheme
  extraPlugins = with pkgs.vimPlugins; [
    vim-colorschemes
  ];
  colorscheme = "wombat256i";

  # basic options
  opts = {
    number = true;
    cursorline = true;
    autochdir = true;
    hidden = true;
    termguicolors = true;
    autoread = true;
    mouse = "a";
    # switch from tabs to s"minimal"paces
    tabstop = 4;
    shiftwidth = 4;
    expandtab = true;
  };

  # bottom line
  plugins.lualine.enable = true;

  # buffer line
  plugins.bufferline = {
    enable = true;
    settings.options = {
      numbers = "ordinal";
      sort_by = "id";
    };
  };

  # keybindings not associated with any package
  keymaps = let
    # switch buffers with <ALT>+number
    switch_buffer_keybinds = lib.map (n: {
      action = ''
        <cmd>lua require("bufferline").go_to_buffer(${builtins.toString n},true) <CR>
      '';
      key = "<A-${builtins.toString n}>";
      options = {
        silent = true;
      };
    }) (lib.range 1 9);
  in
    switch_buffer_keybinds
    ++ [];
}
