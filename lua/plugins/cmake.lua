return {
  {
    "Civitasv/cmake-tools.nvim",

    opts = {
      -- Use CMakePresets.json rather than CMake kits/variants.
      cmake_use_preset = true,

      -- Keep configuration explicit. Reconfigure manually when
      -- CMakeLists.txt, vcpkg.json, or presets change.
      cmake_regenerate_on_save = false,

      -- Builds and configuration errors appear in quickfix.
      cmake_executor = {
        name = "quickfix",
        opts = {},
      },

      -- Run the application in an embedded terminal.
      cmake_runner = {
        name = "terminal",
        opts = {},
      },

      -- Used by :CMakeDebug.
      cmake_dap_configuration = {
        name = "Debug CMake target",
        type = "codelldb",
        request = "launch",
        stopOnEntry = false,
        runInTerminal = true,
      },
    },

    keys = {
      {
        "<leader>mg",
        "<cmd>CMakeGenerate<cr>",
        desc = "CMake configure",
      },
      {
        "<leader>mb",
        "<cmd>CMakeBuild<cr>",
        desc = "CMake build",
      },
      {
        "<leader>mr",
        "<cmd>CMakeRun<cr>",
        desc = "CMake run",
      },
      {
        "<leader>md",
        "<cmd>CMakeDebug<cr>",
        desc = "CMake debug",
      },
      {
        "<leader>mp",
        "<cmd>CMakeSelectConfigurePreset<cr>",
        desc = "Select configure preset",
      },
      {
        "<leader>mP",
        "<cmd>CMakeSelectBuildPreset<cr>",
        desc = "Select build preset",
      },
      {
        "<leader>mt",
        "<cmd>CMakeSelectLaunchTarget<cr>",
        desc = "Select launch target",
      },
      {
        "<leader>mT",
        "<cmd>CMakeSelectBuildTarget<cr>",
        desc = "Select build target",
      },
      {
        "<leader>ms",
        "<cmd>CMakeStopRunner<cr>",
        desc = "Stop running program",
      },
    },
  },

  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>m", group = "CMake" },
      },
    },
  },
}
