local diag_indicator = function(count, level, diagnostics_dict, context)
    if context.buffer:current() then
        return ""
    end
    return ""
end

require("bufferline").setup({
    options = {
        offsets = { { filetype = "NvimTree", text = "Explorer", text_align = "center" } },
        max_name_length = 24,
        tab_size = 22,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = diag_indicator,
        modified_icon = "",
        show_buffer_close_icons = false,
        show_close_icon = false,
        indicator_icon = "",
    },
})
