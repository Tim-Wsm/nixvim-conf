{
  # enable telescope (fuzzy search)
  plugins.web-devicons.enable = true; # dependency of telescope
  plugins.telescope = {
    enable = true;

    keymaps = {
      "<leader>ff" = "find_files";
      "<leader>fg" = "live_grep";
      "<leader>fb" = "buffers";
      "<leader>fh" = "help_tags";
      "<leader>ft" = "treesitter";
    };
  };
}
