-- util.lua
--

local M = { }


--------------
-- packer.nvim
--------------

-- automatically run :PackerCompile whenever plugins.lua is updated
vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("PACKER", { clear = true }),
  pattern = "plugins.lua",
  command = "source <afile> | PackerCompile",
})

-- returns a config file as a function from the config/ directory using a given name
function M.get_config(name)
  return string.format("require(\"config/%s\")", name)
end

-- vscode conditional disable
function M.not_vscode()
  return vim.g.vscode == nil
end

local function string_product(keys)
  if #keys == 1 then
    return keys[1]
  end
  local keys_copy = { }
  for _, key in ipairs(keys) do
    table.insert(keys_copy, key)
  end
  local product = { }
  local first = table.remove(keys_copy, 1)
  for _, a in ipairs(first) do
    if type(a) ~= 'string' then
      vim.cmd('echoerr "Not a valid keys table"')
    end
    for _, b in ipairs(string_product(keys_copy)) do
      table.insert(product, a .. b)
    end
  end
  return product
end

local function expand_keys(keys)
  if type(keys) == 'string' then
    return {keys}
  elseif type(keys[1]) == 'string' then
    return keys
  else
    return string_product(keys)
  end
end

-- return a list of key combinations from lists of modes and keys
function M.get_keys(modes, keys)
  if type(modes) == 'string' then
    modes = {modes}
  end

  local combinations = { }
  for _, mode in ipairs(modes) do
    for _, v in ipairs(expand_keys(keys)) do
      table.insert(combinations, {mode, v})
    end
  end

  return combinations
end

return M

