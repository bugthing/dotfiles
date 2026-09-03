vim.g.llama_config = {
  endpoint_fim = "http://aipro.lan:11435/infill",

  n_prefix = 256,
  n_suffix = 64,
  n_predict = 128,

  t_max_prompt_ms = 500,
  t_max_predict_ms = 3000,

  show_info = 2,
  auto_fim = true,

  ring_n_chunks = 64,
  ring_chunk_size = 64,
  ring_scope = 1024,
  ring_update_ms = 1000,

  keymap_fim_trigger = "<leader>llf",
  keymap_fim_accept_full = "<Tab>",
  keymap_fim_accept_line = "<S-Tab>",
  keymap_fim_accept_word = "<leader>ll]",

  keymap_inst_trigger = "<leader>lli",
  keymap_inst_rerun = "<leader>llr",
  keymap_inst_continue = "<leader>llc",
  keymap_inst_accept = "<Tab>",
  keymap_inst_cancel = "<Esc>",
}
