{
  # enable snacks (plugin collection)
  plugins.snacks = {
    enable = true;
    settings = {
      # enable support for big files
      bigfile.enable = true;
      # enable notifications (message box)
      notifier = {
        enable = true;
        timeout = 3000;
        top_down = false; # places message box on bottom right
        style = "minimal";
        margin = {
          top = 0;
          right = 1;
          bottom = 1;
        };
      };
      # enable indentation highlighting (without animations)
      indent = {
        enable = true;
        only_scope = true;
        only_current = true;
        animate.enabled = false;
      };
      # enable highlighted words
      words = {
        enable = true;
        debounce = 0;
      };
    };
  };
}
