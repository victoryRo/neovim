
-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "po",
      "go",
      "vim",
      "lua",
      "css",
      "sql",
      "vue",
      "bash",
      "html",
      "json",
      "scss",
      "yaml",
      "regex",
      "jsdoc",
      "gomod",
      "gosum",
      "gowork",
      "markdown",
      "gitcommit",
      "gitignore",
      "git_config",
      "javascript",
      "typescript",
      "markdown_inline",
    },
  },
}
