server '52.15.122.157',user: 'stakeway', roles: [:web, :app, :db], primary: true
set :rails_env, 'production'
set :stage, 'production'
set :rack_env, 'production'
set :branch, 'version1.1'