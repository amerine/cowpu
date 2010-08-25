require 'dm-core'
require 'dm-validations'
require 'builder'

class Cowpu < Padrino::Application
  configure do
    ##
    # Application-specific configuration options
    #
    # set :raise_errors, true     # Show exceptions (default for development)
    # set :public, "foo/bar"      # Location for static assets (default root/public)
    # set :reload, false          # Reload application files (default in development)
    # set :default_builder, "foo" # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, "bar"     # Set path for I18n translations (default your_app/locales)
    # enable  :sessions           # Disabled by default
    # disable :flash              # Disables rack-flash (enabled by default if sessions)
    # disable :padrino_helpers    # Disables padrino markup helpers (enabled by default if present)
    # disable :padrino_mailer     # Disables padrino mailer (enabled by default if present)
    # enable  :authentication     # Enable padrino-admin authentication (disabled by default)
    # layout  :my_layout          # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #
  end

  before do
    @recent = Post.recent_posts
  end
  
  get '/' do
    render 'base/index'
  end
  
  get :about, :map => '/about/us' do
    render :haml , '%p Wow this is so rad'
  end

  get '/:year/:month/:slug.html' do
    redirect "/#{params[:slug]}", 301
  end
  
  get ':post' do
    if @post = Post.first(:slug => params[:post])
      render 'posts/show'
    else
      not_found
    end
  end

  get '/meetings' do
    tag = Tag.first(:name => 'meetings')
    @recent = Post.all(:id => (tag.taggings.collect{|i| i.taggable_id}),:limit => 5, :order => [:created_at.desc])
    render 'base/meetings'
  end

end
