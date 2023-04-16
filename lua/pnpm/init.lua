local function pnpm_list()
  local handle = io.popen("pnpm ls --recursive --depth -1 --parseable")
  if handle == nil then return end
  local paths = {}
  for path in handle:lines() do
    paths[#paths + 1] = path
  end
  handle:close()
  return paths
end

local function read_package_info(path)
  local package_json_path = path .. "/package.json"
  local package_json = vim.fn.readfile(package_json_path)
  local package_meta = vim.fn.json_decode(package_json)
  return {
    name = package_meta.name,
    path = path,
  }
end

local M = {}

M.list_workspace_packages = function()
  local paths = pnpm_list()
  if paths == nil then return end
  local workspace_packages = {}
  for i, path in ipairs(paths) do
    workspace_packages[i] = read_package_info(path)
  end
  return workspace_packages
end

return M
