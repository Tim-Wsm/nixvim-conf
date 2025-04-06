{pkgs, ...}: {
  # treesitter support
  plugins.treesitter = {
    enable = true;
  };

  diagnostics = {
    # enable virtual text to display diagnostic messages
    virtual_text = true;
    # only display virtual lines on the current line
    # (this enables lsp-lines to be only shown on the current line)
    virtual_lines = {
      only_current_line = true;
    };
  };

  # lsp support
  plugins.lsp = {
    enable = true;
    servers = {
      # nix
      nixd = {
        enable = true;
        settings = {
          formatting = {
            command = ["${pkgs.alejandra}/bin/alejandra"];
          };
        };
      };

      # rust
      rust_analyzer = {
        enable = true;
        installRustc = false;
        installCargo = false;
        installRustfmt = false;
      };

      # ocaml
      ocamllsp = {
        enable = true;
        package = pkgs.ocamlPackages.ocaml-lsp;
      };

      # c and c++
      clangd = {
        enable = true;
      };

      # language server
      ltex_plus = {
        enable = true;
        package = pkgs.ltex-ls-plus;

        settings = {
          ltex = {
            language = "auto";
          };
        };
      };
    };
  };

  # format on save
  plugins.lsp-format = {
    enable = true;
  };

  # pretty display of diagnostic messages
  plugins.lsp-lines = {
    enable = true;
  };
}
