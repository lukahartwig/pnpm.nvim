local pnpm = require('pnpm');
local telescope = require('telescope')
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local builtin = require("telescope.builtin")
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require("telescope.config").values

local function workspace_package_picker(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "packages",
    finder = finders.new_table {
      results = pnpm.list_workspace_packages(),
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.name,
          ordinal = entry.name,
          path = entry.path,
        }
      end
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local entry = action_state.get_selected_entry().value
        actions.close(prompt_bufnr, true)
        vim.schedule(function()
          builtin.find_files({ cwd = entry.path })
        end)
      end)
      return true
    end,
  }):find()
end

return telescope.register_extension {
  exports = {
    workspace = workspace_package_picker
  },
}
