# LSP Troubleshooting and Performance Guide

## Overview
This guide addresses the LSP errors and image freezing issues you've been experiencing during file searches in Neovim.

## Problems Solved

### 1. LSP Errors on Non-Text Files
**Problem**: LSP servers were trying to process image files (PNG, SVG, etc.), video files, and other binary files, causing errors.

**Solution**: Added comprehensive file type filtering that prevents LSP from attaching to non-text files.

### 2. Image Freezing During Search
**Problem**: When searching for files, image files would freeze the preview window indefinitely.

**Solution**: Enhanced Telescope configuration with file filtering and optimized preview settings.

### 3. Slow Leader Key Response
**Problem**: Leader key commands (like `<leader>ff`, `<leader>fs`) were slow to respond.

**Solution**: Reduced timeout settings and optimized completion performance.

## New Keymaps

### Performance Monitoring
- `<leader>pp` - Check overall performance
- `<leader>po` - Check plugin performance  
- `<leader>pb` - Optimize current buffer

### LSP Troubleshooting
- `<leader>pl` - Check LSP health
- `<leader>pr` - Restart LSP for current buffer

### Safe File Searching (Recommended)
- `<leader>ff` - Find files (safe - prevents LSP errors)
- `<leader>fs` - Live grep (safe)
- `<leader>fg` - Git files (safe)
- `<leader>ft` - Text files only

### Regular Search (Use with Caution)
- `<leader>fF` - Find files (all file types)

## File Types Automatically Filtered

### Images (Prevent LSP errors)
- PNG, JPG, JPEG, GIF, SVG, ICO, BMP, WebP, TIFF, TGA

### Videos (Prevent freezing)
- MP4, AVI, MOV, WMV, FLV, WebM, MKV, M4V, 3GP

### Audio (Prevent LSP errors)
- MP3, WAV, FLAC, AAC, OGG, M4A, WMA

### Documents (Prevent LSP errors)
- PDF, DOC, DOCX, XLS, XLSX, PPT, PPTX, ODT, ODS, ODP

### Archives (Prevent LSP errors)
- ZIP, RAR, 7Z, TAR, GZ, BZ2, XZ, LZMA

### Binaries (Prevent LSP errors)
- EXE, DLL, SO, DYLD, BIN, APP, DMG, DEB, RPM

### Other Problematic Files
- LOCK, LOG, TMP, TEMP, CACHE, BAK, BACKUP

## Performance Optimizations Applied

### LSP Configuration
- **File filtering**: Only text files get LSP services
- **Error handling**: Graceful handling of LSP failures
- **Timeouts**: 5-second timeout for LSP requests
- **Debouncing**: 150ms debounce for text changes
- **Diagnostics**: Reduced diagnostic updates

### Telescope Configuration
- **File filtering**: Automatic exclusion of problematic files
- **Preview optimization**: Disabled preview for non-text files
- **Search optimization**: Skip heavy directories (node_modules, vendor, etc.)
- **Performance flags**: Enhanced caching and sorting

### General Performance
- **Reduced timeouts**: Faster leader key response
- **Optimized scrolling**: Reduced scrolloff for smoother movement
- **Memory management**: Better memory usage patterns
- **Startup optimization**: Deferred heavy operations

## Troubleshooting Steps

### If You Still Experience LSP Errors

1. **Check LSP Health**
   ```
   <leader>pl
   ```

2. **Restart LSP for Current Buffer**
   ```
   <leader>pr
   ```

3. **Check Performance**
   ```
   <leader>pp
   ```

4. **Use Safe File Search**
   - Always use `<leader>ff` instead of `<leader>fF`
   - This prevents LSP from processing problematic files

### If Images Still Freeze

1. **Check File Extensions**
   - Ensure the file has a text-based extension
   - Use `<leader>ft` for text-only file search

2. **Optimize Current Buffer**
   ```
   <leader>pb
   ```

3. **Check Plugin Performance**
   ```
   <leader>po
   ```

## Advanced Configuration

### Custom File Filtering
You can modify the file filtering in `lua/cargdev/plugins/lsp/lspconfig.lua`:

```lua
local non_text_extensions = {
  -- Add or remove extensions as needed
  "png", "jpg", "jpeg", "gif", "svg",
  -- ... other extensions
}
```

### Telescope Customization
Modify the file filter in `lua/cargdev/plugins/telescope.lua`:

```lua
local function filter_files(entry)
  -- Customize filtering logic here
  local filename = entry.filename or entry.value
  -- ... your custom logic
end
```

## Best Practices

### 1. Always Use Safe Search
- `<leader>ff` for file finding
- `<leader>fs` for text searching
- Avoid `<leader>fF` unless you specifically need all file types

### 2. Monitor Performance
- Use `<leader>pp` regularly to check for issues
- Monitor LSP health with `<leader>pl`

### 3. Optimize Large Files
- Use `<leader>pb` for files over 10,000 lines
- Consider disabling heavy features for very large files

### 4. Keep LSP Healthy
- Restart LSP with `<leader>pr` if you experience issues
- Check for LSP errors in the performance report

## Expected Results

After applying these optimizations:

- ✅ **No more LSP errors** on image/video/binary files
- ✅ **No more image freezing** during file searches
- ✅ **Faster leader key response** (reduced from 500ms to 200ms)
- ✅ **Smoother scrolling** and UI performance
- ✅ **Better memory usage** and startup times
- ✅ **Automatic file type filtering** to prevent issues

## Support

If you continue to experience issues:

1. Run `<leader>pp` to get a detailed performance report
2. Check LSP health with `<leader>pl`
3. Use the safe file search commands (`<leader>ff`, `<leader>fs`)
4. Consider restarting LSP with `<leader>pr`

The optimizations maintain all your functionality while significantly improving stability and performance.
