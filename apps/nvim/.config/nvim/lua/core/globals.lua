local global = {};

global.home = os.getenv("HOME")
global.root_dir = vim.fn.getcwd()

return global;
