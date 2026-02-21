return {
  cmd = {
    vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin", 'emmet-language-server'),
    '--stdio'
  },
  filetypes = {
    -- 'astro',
    'css',
    'eruby',
    'html',
    'htmlangular',
    'htmldjango',
    'javascriptreact',
    'less',
    'pug',
    'sass',
    'scss',
    'svelte',
    'templ',
    'typescriptreact',
    'vue',
  },
  root_markers = { '.git' },
}
