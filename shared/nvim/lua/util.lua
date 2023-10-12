#!/usr/bin/env lua

--
-- nvim/lua/util.lua
--

local M = { }

-- packer.nvim
--------------

-- return and source a matching config file from ./config/
function M.get_config(name)
  return string.format("require(\"config/%s\")", name)
end

-- vscode conditional disable
function M.not_vscode()
  return vim.g.vscode == nil
end

-- return a list of key combinations from given vim mode and key lists
function M.get_key_combinations(modes, keys)
  -- create a single table of concatenated keybinds from a given table of keys
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

  -- return a string or an expanded table of strings
  local function expand_keys(keys)
    if type(keys) == 'string' then
      return { keys }
    elseif type(keys[1]) == 'string' then
      return keys
    else
      return string_product(keys)
    end
  end

  if type(modes) == 'string' then
    modes = { modes }
  end

  local combinations = { }
  for _, mode in ipairs(modes) do
    for _, v in ipairs(expand_keys(keys)) do
      table.insert(combinations, { mode, v })
    end
  end

  return combinations
end

return M

