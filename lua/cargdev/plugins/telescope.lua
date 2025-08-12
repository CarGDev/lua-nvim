return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "nvim-telescope/telescope-dap.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local transform_mod = require("telescope.actions.mt").transform_mod

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")

    -- or create your custom action
    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
      end,
    })

    -- File filtering function to prevent LSP errors and image freezing
    local function filter_files(entry)
      local filename = entry.filename or entry.value
      if not filename then return true end
      
      -- Skip non-text files that can cause LSP errors or freezing
      local skip_extensions = {
        -- Images
        "png", "jpg", "jpeg", "gif", "svg", "ico", "bmp", "webp", "tiff", "tga",
        -- Videos
        "mp4", "avi", "mov", "wmv", "flv", "webm", "mkv", "m4v", "3gp",
        -- Audio
        "mp3", "wav", "flac", "aac", "ogg", "m4a", "wma",
        -- Documents
        "pdf", "doc", "docx", "xls", "xlsx", "ppt", "pptx", "odt", "ods", "odp",
        -- Archives
        "zip", "rar", "7z", "tar", "gz", "bz2", "xz", "lzma",
        -- Binaries
        "exe", "dll", "so", "dylib", "bin", "app", "dmg", "deb", "rpm",
        -- Other problematic files
        "lock", "log", "tmp", "temp", "cache", "bak", "backup"
      }
      
      for _, ext in ipairs(skip_extensions) do
        if filename:match("%." .. ext .. "$") then
          return false
        end
      end
      
      -- Skip hidden files and directories (except .git)
      if filename:match("/%.") and not filename:match("/%.git/") then
        return false
      end
      
      -- Skip node_modules and other heavy directories
      if filename:match("/node_modules/") or 
         filename:match("/vendor/") or 
         filename:match("/%.git/") or
         filename:match("/dist/") or
         filename:match("/build/") or
         filename:match("/target/") then
        return false
      end
      
      return true
    end

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        -- Performance optimizations
        cache_picker = {
          num_pickers = -1,
        },
        -- Enhanced preview with file filtering
        preview = {
          treesitter = false, -- Disable treesitter in preview for better performance
          timeout = 100, -- Reduce preview timeout
          -- Add file filtering to preview
          file_previewer = require("telescope.previewers").vim_buffer_cat.new({
            previewer_options = {
              -- Skip preview for non-text files
              file_filter = filter_files,
            },
          }),
        },
        -- Optimize sorting
        sorting_strategy = "ascending",
        -- Add file filtering to all pickers
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-t>"] = trouble_telescope.open,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          -- Performance optimizations
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          no_ignore = false,
          follow = false, -- Don't follow symlinks for better performance
          -- Add file filtering
          file_filter = filter_files,
          -- Skip heavy directories
          search_dirs = {
            -- Exclude heavy directories from search
            exclude = {
              "node_modules",
              "vendor",
              ".git",
              "dist",
              "build",
              "target",
              "coverage",
              ".next",
              ".nuxt",
              ".output"
            }
          },
        },
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
          -- Performance optimizations
          glob_pattern = { "!**/.git/*", "!**/node_modules/*", "!**/vendor/*" },
          previewer = false, -- Disable previewer for live_grep for better performance
          -- Add file filtering for grep
          file_filter = filter_files,
          -- Skip binary files in grep
          search = function(query_string)
            return query_string .. " -I" -- -I flag skips binary files
          end,
        },
        -- Optimize other pickers
        buffers = {
          sort_lastused = true,
          ignore_current_buffer = true,
        },
        git_files = {
          git_command = { "git", "ls-files", "--exclude-standard" },
          -- Add file filtering for git files
          file_filter = filter_files,
        },
        -- Add specific picker for text files only
        text_files = {
          find_command = { "rg", "--files", "--type", "text", "--hidden" },
          file_filter = filter_files,
          previewer = require("telescope.previewers").vim_buffer_cat.new({
            previewer_options = {
              file_filter = filter_files,
            },
          }),
        },
      },
      -- Performance optimizations
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    -- Load extensions
    telescope.load_extension("fzf")
    telescope.load_extension("dap")
    
    -- Add custom picker for safe file searching (text files only)
    telescope.register_module("safe_files", {
      exports = {
        find_files = function(opts)
          opts = opts or {}
          opts.file_filter = filter_files
          opts.previewer = require("telescope.previewers").vim_buffer_cat.new({
            previewer_options = {
              file_filter = filter_files,
            },
          })
          return telescope.builtin.find_files(opts)
        end,
      },
    })
  end,
}
