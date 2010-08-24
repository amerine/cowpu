set :keep_releases,       5
set :application,         "cowpu"
set :repository,          "git@github.com:timmyc/cowpu.git"
set :deploy_to,           "/home/timmy/cowpu"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "cowpu"                          # Your HTTP server, Apache/etc
role :app, "cowpu"                          # This may be the same as your `Web` server

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
   
  desc "Symlink db config and public assets"    
  task :symlink_db_assets, :roles => :app, :except => {:no_release => true, :no_symlink => true} do
    
  end
end

after "deploy:update_code", "deploy:symlink_db_assets"
