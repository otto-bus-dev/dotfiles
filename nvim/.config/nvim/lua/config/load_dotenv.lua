local M = {}

-- Load a .env file from path (defaults to current working dir + "/.env")
function M.load(path)
  path = path or (vim.fn.getcwd() .. "/.env")
  if vim.fn.filereadable(path) == 0 then
    return false
  end

  for line in io.lines(path) do
    -- skip comments and empty lines
    if not line:match("^%s*#") and line:match("%S") then
      local k, v = line:match("^%s*([%w_]+)%s*=%s*(.-)%s*$")
      if k and v then
        -- remove surrounding quotes if present
        v = v:gsub('^"(.*)"$', "%1")
        v = v:gsub("^'(.*)'$", "%1")
        vim.env[k] = v
      end
    end
  end

  return true
end

return M
