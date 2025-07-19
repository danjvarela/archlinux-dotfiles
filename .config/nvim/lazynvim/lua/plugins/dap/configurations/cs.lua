local dap = require("dap")
local dotnet = require("easy-dotnet")
local debug_dll = nil

local function rebuild_project(co, path)
  local spinner = require("easy-dotnet.ui-modules.spinner").new()
  spinner:start_spinner("Building")
  vim.fn.jobstart(string.format("dotnet build %s", path), {
    on_exit = function(_, return_code)
      if return_code == 0 then
        spinner:stop_spinner("Built successfully")
      else
        spinner:stop_spinner("Build failed with exit code " .. return_code, vim.log.levels.ERROR)
        error("Build failed")
      end
      coroutine.resume(co)
    end,
  })
  coroutine.yield()
end

local function ensure_dll()
  if debug_dll ~= nil then
    return debug_dll
  end
  local dll = dotnet.get_debug_dll()
  debug_dll = dll
  return dll
end

local function file_exists(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "file"
end

dap.listeners.before["event_terminated"]["easy-dotnet"] = function()
  debug_dll = nil
end

return {
  {
    type = "coreclr",
    name = "Program",
    request = "launch",
    env = function()
      local dll = ensure_dll()
      local vars = dotnet.get_environment_variables(dll.project_name, dll.absolute_project_path, false)
      return vars or nil
    end,
    program = function()
      local dll = ensure_dll()
      local co = coroutine.running()
      rebuild_project(co, dll.project_path)
      if not file_exists(dll.target_path) then
        error("Project has not been built, path: " .. dll.target_path)
      end
      return dll.target_path
    end,
    cwd = function()
      local dll = ensure_dll()
      return dll.absolute_project_path
    end,
  },
}
