return {
  "epwalsh/obsidian.nvim",
  version = "*",
  -- lazy = true,
  -- event = {
  --   "BufReadPre " .. vim.fn.expand("~") .. "/Documents/second-brain/*",
  --   "BufNewFile " .. vim.fn.expand("~") .. "/Documents/second-brain/*",
  -- },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Documents/second-brain",
        overrides = {
          notes_subdir = "000-permanent-notes",
          daily_notes = {
            folder = "002-daily-notes",
            date_format = "%Y-%m-%d",
            alias_format = "%B %-d, %Y",
            default_tags = { "daily-notes" },
            template = nil,
          },
          completion = {
            nvim_cmp = false,
          },
          new_notes_location = "003-fleeting-notes",
          ---@param title string|?
          ---@return string
          note_id_func = function(title)
            local suffix = ""
            if title ~= nil then
              -- If title is given, transform it into valid file name.
              suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
              return suffix
            else
              -- If title is nil, just add 4 random uppercase letters to the suffix.
              for _ = 1, 4 do
                suffix = suffix .. string.char(math.random(65, 90))
              end
              return tostring(os.time()) .. "-" .. suffix
            end
          end,
          ---@param spec { id: string, dir: obsidian.Path, title: string|? }
          ---@return string|obsidian.Path The full path to the new note.
          note_path_func = function(spec)
            -- This is equivalent to the default behavior.
            local path = spec.dir / tostring(spec.id)
            return path:with_suffix(".md")
          end,
          ---@return table
          note_frontmatter_func = function(note)
            -- Add the title of the note as an alias.
            if note.title then
              note:add_alias(note.title)
            end

            local out = { id = note.id, aliases = note.aliases, tags = note.tags }

            -- `note.metadata` contains any manually added fields in the frontmatter.
            -- So here we just make sure those fields are kept in the frontmatter.
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
              for k, v in pairs(note.metadata) do
                out[k] = v
              end
            end

            return out
          end,
          wiki_link_func = function(opts)
            return require("obsidian.util").wiki_link_id_prefix(opts)
          end,
          templates = {
            folder = "templates",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
            substitutions = {},
          },
          ---@param url string
          follow_url_func = function(url)
            vim.ui.open(url) -- need Neovim 0.10.0+
          end,
          ---@param img string
          follow_img_func = function(img)
            vim.fn.jobstart({ "xdg-open", img }) -- linux
          end,
          ui = {
            enable = false,
          },
          attachments = {
            img_folder = "attachments",
          },
        },
      },
    },
  },
}
