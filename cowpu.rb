require 'rubygems'
require 'sinatra'
require 'environment'

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

helpers do
  def partial(template, *args)
    template_array = template.to_s.split('/')
    template = template_array[0..-2].join('/') + "/_#{template_array[-1]}"
    options = args.last.is_a?(Hash) ? args.pop : {}
    options.merge!(:layout => false)
    if collection = options.delete(:collection) then
      collection.inject([]) do |buffer, member|
        buffer << haml(:"#{template}", options.merge(:layout =>
        false, :locals => {template_array[-1].to_sym => member}))
      end.join("\n")
    else
      haml(:"#{template}", options)
    end
  end
end

before do
  @recent = Post.recent_posts
end

get '/' do
  haml :index
end

# Blog Posts
get '/:year/:month/:slug.html' do
  redirect "/#{params[:slug]}", 301
end

get '/meetings' do
  tag = Tag.first(:name => 'meetings')
  @recent = Post.all(:id => (tag.taggings.collect{|i| i.taggable_id}),:limit => 5, :order => [:created_at.desc]) if tag
  haml :meetings
end

# Members

get '/members' do
  haml :'members/index'
end

get '/members/signup' do
  @member = Member.new
  haml :'members/signup' 
end

get '/members/create' do
  @member = Member.new(params[:member])
  if @member.save
    haml :'members/thanks'
  else
    haml :'members/signup'
  end
end

# Default blog post route
get ':post' do
  if @post = Post.first(:slug => params[:post])
    haml :'posts/show'
  else
    not_found
  end
end