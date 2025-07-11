{
  programs.nvf.settings.vim = {
    git = {
      enable = true;
      gitsigns = {
        enable = true;
        mappings = {
          stageHunk = "<leader>gs";
          undoStageHunk = "<leader>gu";
          resetHunk = "<leader>gr";
          stageBuffer = "<leader>gS";
          resetBuffer = "<leader>gR";
          previewHunk = "<leader>gP";
          blameLine = "<leader>gb";
          diffThis = "<leader>gd";
          diffProject = "<leader>gD";
          toggleBlame = "<leader>gtb";
          toggleDeleted = "<leader>gtd";
        };
      };
    };

    binds.whichKey.register = {
      "<leader>g" = "+Git";
      "<leader>gt" = "+Toggle";
    };
  };
}
