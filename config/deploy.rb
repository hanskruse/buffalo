# Application name
set :application, 'buffalo'

# Git repository url
set :repo_url, 'git@psgit.oxid-esales.com:psprojects/buffalo-boots.git'

# Uncomment line below if you want to input of which branch to deploy
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Remove path of where application will be deployed
# This can be moved to environment files separately
#set :deploy_to, "</path/to/your/application>"

# Which VCS to use (currently supporting GIT only)
set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# Files which are environment independent
# On release path those files will be symlinked to shared folder
set :linked_files, %w{htdocs/.htaccess htdocs/config.inc.php}

# Directories which are environment independent
# On release path those directories will be symlinked to shared folder
set :linked_dirs, %w{htdocs/log htdocs/tmp htdocs/cache htdocs/export htdocs/out/downloads htdocs/out/media htdocs/out/pictures upgrade/cache}

# Uncomment below to change path of ruby env
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# How many releases will be kept in remote environment
set :keep_releases, 5


namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end
  
  after :finishing, 'oxid:clear_cache'
  after :finishing, 'oxid:upgrade_database'
  after :finishing, 'oxid:fix_states'
  after :finishing, 'oxid:update_views'

  after :finishing, 'deploy:cleanup'
end
