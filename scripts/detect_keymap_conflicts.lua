--- detect_keymap_conflicts.lua
--- Detects duplicate keymap bindings across neovim config files.
--- Run from the nvim config root: lua scripts/detect_keymap_conflicts.lua

local handle = io.popen("find lua -name '*.lua' -print")
if not handle then
  print("Error: could not search for lua files")
  os.exit(1)
end
local files = {}
for path in handle:lines() do
  files[#files + 1] = path
end
handle:close()

--- Build a lookup table: line_starts[i] = byte position where line i begins.
local function build_line_index(content)
  local starts = { 1 }
  for i = 1, #content do
    if content:sub(i, i) == "\n" then
      starts[#starts + 1] = i + 1
    end
  end
  return starts
end

--- Binary search to find the line number for a byte position.
local function line_at(line_starts, pos)
  local lo, hi = 1, #line_starts
  while lo < hi do
    local mid = math.floor((lo + hi + 1) / 2)
    if line_starts[mid] <= pos then
      lo = mid
    else
      hi = mid - 1
    end
  end
  return lo
end

--- Return true if `pos` sits after a "--" comment marker on the same line.
local function is_in_comment(content, line_starts, pos)
  local ln = line_at(line_starts, pos)
  local line_start = line_starts[ln]
  local before = content:sub(line_start, pos - 1)
  return before:match("%-%-") ~= nil
end

--- Split a mode argument into individual mode strings.
--- "n" -> {"n"},  {"n", "v"} -> {"n", "v"}
local function extract_modes(mode_arg)
  local modes = {}
  for m in mode_arg:gmatch([=["([^"]+)"]=]) do
    modes[#modes + 1] = m
  end
  if #modes == 0 then
    for m in mode_arg:gmatch("'([^']+)'") do
      modes[#modes + 1] = m
    end
  end
  if #modes == 0 then
    local trimmed = mode_arg:gsub("^%s+", ""):gsub("%s+$", "")
    if #trimmed > 0 then
      modes[#modes + 1] = trimmed
    end
  end
  return modes
end

-- Patterns to match keymap setter calls.
-- Two variants per caller style: single-string mode and table mode.
-- Using [=[...]=] to avoid issues with ]] inside patterns.
-- () captures the byte position for line-number lookup.
local patterns = {
  -- vim.keymap.set("n", "<key>", ...)
  [=[()vim%.keymap%.set%(%s*["']([^"']+)["']%s*,%s*["']([^"']+)["']]=],
  -- vim.keymap.set({"n", "v"}, "<key>", ...)
  [=[()vim%.keymap%.set%(%s*(%b{})%s*,%s*["']([^"']+)["']]=],
  -- keymap.set("n", "<key>", ...)
  [=[()keymap%.set%(%s*["']([^"']+)["']%s*,%s*["']([^"']+)["']]=],
  -- keymap.set({"n", "v"}, "<key>", ...)
  [=[()keymap%.set%(%s*(%b{})%s*,%s*["']([^"']+)["']]=],
  -- keymap("n", "<key>", ...) — when local keymap = vim.keymap.set
  [=[()keymap%(%s*["']([^"']+)["']%s*,%s*["']([^"']+)["']]=],
  -- keymap({"n", "v"}, "<key>", ...)
  [=[()keymap%(%s*(%b{})%s*,%s*["']([^"']+)["']]=],
  -- map("n", "<key>", ...) — wrapper function
  [=[()map%(%s*["']([^"']+)["']%s*,%s*["']([^"']+)["']]=],
  -- map({"n", "v"}, "<key>", ...)
  [=[()map%(%s*(%b{})%s*,%s*["']([^"']+)["']]=],
}

local keymaps = {} -- "mode|lhs" -> list of "file:line"
local seen = {}    -- dedup: "file:line:lhs" -> true

for _, f in ipairs(files) do
  local fh = io.open(f, "r")
  if fh then
    -- Read entire file so patterns can span multiple lines (%s matches \n).
    local content = fh:read("*a")
    fh:close()
    local line_starts = build_line_index(content)

    for _, pat in ipairs(patterns) do
      for pos, mode_arg, lhs in content:gmatch(pat) do
        if not is_in_comment(content, line_starts, pos) then
          local ln = line_at(line_starts, pos)
          local dedup_key = f .. ":" .. ln .. ":" .. lhs
          if not seen[dedup_key] then
            seen[dedup_key] = true
            local modes = extract_modes(mode_arg)
            for _, mode in ipairs(modes) do
              local key = mode .. "|" .. lhs
              keymaps[key] = keymaps[key] or {}
              keymaps[key][#keymaps[key] + 1] = string.format("%s:%d", f, ln)
            end
          end
        end
      end
    end
  end
end

-- Collect and sort conflicts
local conflicts = {}
for key, locations in pairs(keymaps) do
  if #locations > 1 then
    local mode, lhs = key:match("^(.-)|(.*)")
    conflicts[#conflicts + 1] = { mode = mode, lhs = lhs, locations = locations }
  end
end

table.sort(conflicts, function(a, b)
  if a.mode == b.mode then return a.lhs < b.lhs end
  return a.mode < b.mode
end)

if #conflicts == 0 then
  print("No duplicate keymaps found.")
else
  print(string.format("Found %d conflicting keymap(s):\n", #conflicts))
  for _, c in ipairs(conflicts) do
    print(string.format("  [%s] %s", c.mode, c.lhs))
    for _, loc in ipairs(c.locations) do
      print("    - " .. loc)
    end
    print()
  end
end
