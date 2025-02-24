{pkgs, ...}: {
  # treesitter support
  plugins.treesitter = {
    enable = true;
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

      # language server
      ltex_plus = {
        enable = true;
        package = pkgs.ltex-ls-plus;
      };
    };
  };

  # border for lsp "hover" output
  extraConfigLua = ''
    local _border = "rounded"

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
        border = _border
      }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help, {
        border = _border
      }
    )

    vim.diagnostic.config{
      float={border=_border}
    };

    require('lspconfig.ui.windows').default_options = {
      border = _border
    }

    config = function(_, opts)
      local lspconfig = require('lspconfig')
      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end;
  '';

  # format on save
  plugins.lsp-format = {
    enable = true;
  };
}
