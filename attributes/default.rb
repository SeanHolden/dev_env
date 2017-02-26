default['dev_env']['user'] = 'vagrant'
default['dev_env']['app_name'] = 'test_app'
default['dev_env']['ohmyzsh_plugins'] = %w(git)
default['dev_env']['repos'] = %w(
  git@github.com:SeanHolden/ReactReduxStarter.git
)
default['dev_env']['environment_variables'] = %w(
  EDITOR="vim"
)
default['dev_env']['aliases'] = %w(
  befs="bundle exec foreman start"
)
