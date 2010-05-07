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

  get '/rss.xml' do
    @posts = Post.all(:limit => 10)
    builder do |xml|
      xml.instruct!
      xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
        xml.channel do
          xml.title "COWPU"
          xml.description "Central Oregon Web Professionals Usergroup"
          xml.link 'http://www.cowpu.com'

          for post in @posts
            xml.item do
              xml.title post.title
              xml.description post.body
              xml.pubDate post.created_at.to_s
              xml.link "http://www.cowpu.com/#{post.slug}"
            end
          end
        end
      end
    end
  end

  get '/atom.xml' do
    @posts = Post.all(:limit => 10)
    builder do |xml|
      xml.instruct!
      xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
        xml.title   "COWPU"
        xml.link    "rel" => "self", "href" => 'http://www.cowpu.com'
        xml.id      'http://www.cowpu.com'
        xml.updated @posts.first.created_at.strftime "%Y-%m-%dT%H:%M:%SZ" if @posts.any?
        xml.author  { xml.name "COWPU" }

        @posts.each do |post|
          xml.entry do
            xml.title   post.title
            xml.link    "rel" => "alternate", "href" => "http://www.cowpu.com/#{post.slug}"
            xml.id      "http://www.cowpu.com/#{post.slug}"
            xml.updated post.created_at.strftime "%Y-%m-%dT%H:%M:%SZ"
            xml.author  { xml.name post.account.email }
            xml.summary post.body
          end
        end
      end
    end
  end
  
  ##
  # You can configure for a specified environment like:
  #
  #   configure :development do
  #     set :foo, :bar
  #   end
  #

  ##
  # You can manage errors like:
  #
  #   error 404 do
  #     render 'errors/404'
  #   end
  #

end
