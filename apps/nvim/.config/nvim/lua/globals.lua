vim.g.home = os.getenv("HOME")
vim.g.root_dir = vim.fn.getcwd() -- this is tab local directory
vim.g.nvim_dir = vim.fn.stdpath("config")

vim.g.nxt = {
  home = os.getenv("HOME"),
  project_root_dir = vim.fn.getcwd(), -- this is tab local directory
  nvim_dir = vim.fn.stdpath("config"),
}
