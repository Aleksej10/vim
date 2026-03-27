return {
  {
    "ggandor/lightspeed.nvim",
    init = function()
      local function lightspeed_expr(key)
        -- reg_recording() and reg_executing() return empty strings if inactive
        if vim.fn.reg_recording() == "" and vim.fn.reg_executing() == "" then
          return "<Plug>Lightspeed_" .. key
        else
          return key
        end
      end

      -- expr = true tells Neovim to evaluate the function's return value as the command
      -- remap = true is required here because <Plug> is a virtual sequence that needs re-evaluation
      vim.keymap.set('n', 'f', function() return lightspeed_expr('f') end, { expr = true, remap = true })
      vim.keymap.set('n', 'F', function() return lightspeed_expr('F') end, { expr = true, remap = true })
      vim.keymap.set('n', 't', function() return lightspeed_expr('t') end, { expr = true, remap = true })
      vim.keymap.set('n', 'T', function() return lightspeed_expr('T') end, { expr = true, remap = true })
    end,
    config = function()
      require('lightspeed').setup({
        -- jump_to_first_match = true,
        -- jump_on_partial_input_safety_timeout = 400,
        -- This can get _really_ slow if the window has a lot of content,
        -- turn it on only if your machine can always cope with it.
        -- jumpt_to_unique_chars = true,
        -- grey_out_search_area = true,
        match_only_the_start_of_same_char_seqs = true,
        limit_ft_matches = 5,
        -- full_inclusive_prefix_key = '<Plug>Lightspeed_x',
        -- By default, the values of these will be decided at runtime,
        -- based on `jump_to_first_match`.
        labels = nil,
        cycle_group_fwd_key = nil,
        cycle_group_bwd_key = nil,
      })
    end,
  }
}
