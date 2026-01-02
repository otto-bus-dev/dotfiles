-- Track macro recording and capture keys
_G.macro_recording = {
  register = "",
  keys = "",
}

vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function()
    local reg = vim.fn.reg_recording()
    _G.macro_recording.register = reg
    _G.macro_recording.keys = ""

    -- Capture keys during recording
    vim.on_key(function(key)
      if _G.macro_recording.register ~= "" then
        -- Convert key to readable format
        local readable_key = vim.fn.keytrans(key)
        _G.macro_recording.keys = _G.macro_recording.keys .. readable_key

        vim.schedule(function()
          require("lualine").refresh()
        end)
      end
    end, vim.api.nvim_create_namespace("lualine_macro_recording"))
  end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  callback = function()
    _G.macro_recording.register = ""
    _G.macro_recording.keys = ""

    -- Stop capturing keys
    vim.on_key(nil, vim.api.nvim_create_namespace("lualine_macro_recording"))
    require("lualine").refresh()
  end,
})
