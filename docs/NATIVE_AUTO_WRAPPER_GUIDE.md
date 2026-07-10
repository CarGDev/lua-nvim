# Native Auto Wrapper Configuration

## 🎯 **Overview**

Your Neovim is now configured with native auto wrapper functionality using built-in Neovim features - no additional packages required!

## ✨ **Features**

### **Automatic Text Wrapping**
- **Text files**: Auto-wrap at 80 characters
- **Code files**: Auto-wrap comments at 100 characters  
- **Documentation**: Auto-wrap at 78 characters
- **Configuration files**: Auto-wrap comments at 80 characters

### **Smart Formatting**
- **Break at word boundaries**: Lines break at natural word boundaries
- **Preserve indentation**: Wrapped lines maintain proper indentation
- **Visual indicators**: Shows break indicators (↪) for wrapped lines
- **Color column**: Visual guide at specified text width

## 🎮 **Keymaps**

### **Text Wrapping Controls**
| Keymap | Description |
|--------|-------------|
| `<leader>tw` | Toggle line wrapping |
| `<leader>tl` | Toggle line break |
| `<leader>tx` | Show 80 char column guide |
| `<leader>tH` | Hide column guide |

### **Text Formatting**
| Keymap | Description |
|--------|-------------|
| `<leader>tf` | Format current paragraph |
| `<leader>tF` | Format entire file |
| `<leader>tf` (visual) | Format selected text |

### **Text Width Settings**
| Keymap | Description |
|--------|-------------|
| `<leader>t80` | Set text width to 80 characters |
| `<leader>t100` | Set text width to 100 characters |
| `<leader>t120` | Set text width to 120 characters |
| `<leader>t0` | Disable text width (no wrapping) |

### **Auto-wrap Controls**
| Keymap | Description |
|--------|-------------|
| `<leader>ta` | Enable auto-wrap text |
| `<leader>tA` | Disable auto-wrap text |
| `<leader>tc` | Enable auto-wrap comments |
| `<leader>tC` | Disable auto-wrap comments |

### **Indentation and Display**
| Keymap | Description |
|--------|-------------|
| `<leader>ti` | Toggle break indent |
| `<leader>tB` | Show break indicator (↪) |
| `<leader>tb` | Hide break indicator |

## 📁 **File Type Specific Settings**

### **Text and Documentation Files**
- **File types**: `text`, `markdown`, `gitcommit`, `mail`
- **Text width**: 80 characters
- **Auto-wrap**: Enabled for all text
- **Line break**: At word boundaries

### **Code Files**
- **File types**: `lua`, `javascript`, `typescript`, `python`, `java`, `cpp`, `c`, `rust`, `go`
- **Text width**: 100 characters
- **Auto-wrap**: Comments only
- **Format options**: Smart comment wrapping

### **Documentation Files**
- **File types**: `help`, `man`
- **Text width**: 78 characters
- **Auto-wrap**: Enabled for all text
- **Line break**: At word boundaries

### **Configuration Files**
- **File types**: `conf`, `config`, `ini`, `toml`, `yaml`, `json`
- **Text width**: 80 characters
- **Auto-wrap**: Comments only

## 🔧 **Native Neovim Settings**

### **Core Settings**
```lua
-- Text wrapping
opt.wrap = true                    -- Enable line wrapping
opt.linebreak = true              -- Break at word boundaries
opt.breakindent = true            -- Preserve indentation
opt.showbreak = "↪ "             -- Break indicator
opt.breakindentopt = "shift:2"    -- Indent wrapped lines

-- Text width
opt.textwidth = 120                -- Default text width
opt.colorcolumn = "120"            -- Visual column guide
```

### **Format Options**
```lua
opt.formatoptions = "jcroqlnt"    -- Format options
-- j: Remove comment leader when joining lines
-- c: Auto-wrap comments using textwidth
-- r: Auto-wrap comments when pressing Enter
-- o: Auto-wrap comments when pressing 'o' or 'O'
-- q: Allow formatting of comments with 'gq'
-- l: Long lines are not broken in insert mode
-- n: Recognize numbered lists
-- t: Auto-wrap text using textwidth
```

## 📝 **Usage Examples**

### **1. Writing Documentation**
```markdown
# This is a long title that will automatically wrap at 80 characters when you type it

This is a long paragraph that will automatically wrap at word boundaries when it reaches 80 characters, making your documentation more readable and properly formatted.
```

### **2. Writing Code Comments**
```lua
-- This is a very long comment that will automatically wrap at 100 characters when you press Enter or 'o', making your code more readable and maintaining proper indentation
local function example()
  -- This comment will also wrap automatically
  return "example"
end
```

### **3. Writing Git Commit Messages**
```bash
# This commit message will automatically wrap at 80 characters
git commit -m "This is a very long commit message that describes the changes made to the codebase in detail"
```

## 🎨 **Visual Features**

### **Break Indicators**
- **Symbol**: `↪` shows where lines are wrapped
- **Toggle**: Use `<leader>tB` to show, `<leader>tb` to hide

### **Color Column**
- **Guide**: Visual line at text width
- **Toggle**: Use `<leader>tx` to show, `<leader>tH` to hide

### **Indentation**
- **Preserved**: Wrapped lines maintain indentation
- **Smart**: Proper indentation for code blocks

## 🔍 **Troubleshooting**

### **Text Not Wrapping**
1. Check if wrapping is enabled: `:set wrap?`
2. Verify text width: `:set textwidth?`
3. Check format options: `:set formatoptions?`

### **Comments Not Wrapping**
1. Ensure format option 'c' is set: `:set formatoptions+=c`
2. Check file type: `:set filetype?`
3. Verify text width is set: `:set textwidth?`

### **Indentation Issues**
1. Enable break indent: `:set breakindent`
2. Check break indent options: `:set breakindentopt?`
3. Verify smart indent: `:set smartindent?`

## 🚀 **Advanced Configuration**

### **Custom File Type Settings**
Add to your configuration:
```lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "your_filetype" },
  callback = function()
    vim.opt_local.textwidth = 120
    vim.opt_local.formatoptions:append("c")
  end,
})
```

### **Custom Break Indicator**
```lua
vim.opt.showbreak = "⤷ "  -- Custom break indicator
```

### **Custom Color Column**
```lua
vim.opt.colorcolumn = "80,100,120"  -- Multiple column guides
```

## ✅ **Benefits of Native Configuration**

- **No additional packages**: Uses built-in Neovim features
- **Fast and lightweight**: No external dependencies
- **Consistent behavior**: Works the same across all Neovim installations
- **Easy to customize**: Simple Lua configuration
- **Reliable**: No plugin conflicts or compatibility issues

Your native auto wrapper is now fully configured and ready to use! 🎉 
