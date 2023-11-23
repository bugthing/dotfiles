-- vim.test.strategy = "vimux"

local g = vim.g

g['test#strategy'] = {
  nearest = 'vimux',
  file = 'vimux',
  suite = 'vimux'
}

g['test#ruby'] = {
  rspec = {
    executable = 'overmind run bundle exec rspec'
  }
}
g['test#ruby#rspec#executable'] = 'overmind run bundle exec rspec'
