-- https://www.youtube.com/watch?v=9gUatBHuXE0
-- set text in a buffer by number

local bufnr = 4  -- echo nvim_get_current_buf()

-- run manually with :source %<CR>


vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("Tutorial", {clear=true}),
  pattern = "*.txt",
  callback = function()
    -- vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, {"Hello", "world"})
    vim.fn.jobstart({"echo", "wat"}, {
      stdout_buffered = true,  -- only send output as full lines

      on_stdout = function(_, data)
        if data then
          vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
        end
      end,

      on_stderr = function(_, data)
        if data then
          vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
        end
      end,
    })
  end,
})
