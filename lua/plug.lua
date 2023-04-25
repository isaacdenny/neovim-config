-- [[ plug.lua ]]

vim.g.plugin_home = vim.fn.stdpath("data") .. "/site/pack/packer"

--- Install packer if it has not been installed.
--- Return:
--- true: if this is a fresh install of packer
--- false: if packer has been installed
local function packer_ensure_install()
  -- Where to install packer.nvim -- the package manager (we make it opt)
  local packer_dir = vim.g.plugin_home .. "/opt/packer.nvim"

  if vim.fn.glob(packer_dir) ~= "" then
    return false
  end

  -- Auto-install packer in case it hasn't been installed.
  vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})

  local packer_repo = "https://github.com/wbthomason/packer.nvim"
  local install_cmd = string.format("!git clone --depth=1 %s %s", packer_repo, packer_dir)
  vim.cmd(install_cmd)

  return true
end

local fresh_install = packer_ensure_install()

return require('packer').startup({function(use)
  -- [[ Plugins Go Here ]]
  -- it is recommended to put impatient.nvim before any other plugins
  use { "lewis6991/impatient.nvim", config = [[require('impatient')]] }

  use { "wbthomason/packer.nvim", opt = true }

  use {                                              -- filesystem navigation
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'        -- filesystem icons
  }

  use { "nvim-tree/nvim-web-devicons", event = "VimEnter" }

  -- fancy start screen
  use { "glepnir/dashboard-nvim", 
    event = "VimEnter",
    config = function() 
      require('dashboard').setup({
        theme = 'doom',
        config = {
          header = {}, --your header
          center = {
            {
              icon = ' ',
              icon_hl = 'Title',
              desc = 'Find File           ',
              desc_hl = 'String',
              key = 'b',
              keymap = 'SPC f f',
              key_hl = 'Number',
              action = 'lua print(2)'
            },
            {
              icon = ' ',
              desc = 'Find Dotfiles',
              key = 'f',
              keymap = 'SPC f d',
              action = 'lua print(3)'
            },
          },
          footer = {}  --your footer
        }      
      })
    end,
    requires = {'nvim-tree/nvim-web-devicons'}
  }

  use { "akinsho/bufferline.nvim", event = "VimEnter",
    config = [[require('config.bufferline')]] 
  }

  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "VimEnter",
    config = [[require('config.indent-blankline')]],
  }

  use { "onsails/lspkind-nvim", event = "VimEnter" }

  -- completion driver
  use { "hrsh7th/nvim-cmp", after = "lspkind-nvim", config = [[require('config.nvim-cmp')]] }

  -- nvim-cmp completion sources
  use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }
  use { "hrsh7th/cmp-path", after = "nvim-cmp" }
  use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }
  use { "hrsh7th/cmp-omni", after = "nvim-cmp" }
  use { "quangnguyen30192/cmp-nvim-ultisnips", after = { "nvim-cmp", "ultisnips" } }

  -- Python indent (follows the PEP8 style)
  use { "Vimjas/vim-python-pep8-indent", ft = { "python" } }

  -- Python-related text object
  use { "jeetsukumaran/vim-pythonsense", ft = { "python" } }

  use { "machakann/vim-swap", event = "VimEnter" }

  -- File search, tag search and more
  use { "Yggdroot/LeaderF", cmd = "Leaderf", run = ":LeaderfInstallCExtension" }

  use {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    requires = { { "nvim-lua/plenary.nvim" } },
  }
  -- search emoji and other symbols
  use { "nvim-telescope/telescope-symbols.nvim", after = "telescope.nvim" }

  -- [[ Theme ]]
  use "shaunsingh/nord.nvim"

end,
config = {
  package_root = vim.fn.stdpath('config') .. '/site/pack'
}})
