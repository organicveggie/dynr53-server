# config.ru

root = File.expand_path('..', __FILE__)
require File.join(root, %w[lib dynr53])

run Dynr53Server
