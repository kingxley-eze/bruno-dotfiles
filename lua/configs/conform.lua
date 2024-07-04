local prettier = { "prettier" }

require("conform").setup {
  notify_on_error = false,
  formatters_by_ft = {
    javascript = { prettier },
    typescript = { prettier },
    javascriptreact = { prettier },
    typescriptreact = { prettier },
    json = { prettier },
    jsonc = { prettier },
    css = { prettier },
    html = { prettier },
    markdown = { prettier },
    lua = { "stylua" },
    go = { "goimports", "gofumpt" },
    ["vue"] = { "prettier" },
    ["scss"] = { "prettier" },
    ["less"] = { "prettier" },
    ["yaml"] = { "prettier" },
    ["markdown.mdx"] = { "prettier" },
    ["graphql"] = { "prettier" },
    ["handlebars"] = { "prettier" },
  },
}
