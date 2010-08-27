require 'rubygems'
require 'activerecord'
require 'sqlite3'
require 'sinatra/activerecord'
require 'haml'

require 'sinatra' unless defined?(Sinatra)

configure do

  # load models
  $LOAD_PATH.unshift("#{File.dirname(__FILE__)}/models")
  Dir.glob("#{File.dirname(__FILE__)}/models/*.rb") { |lib| require File.basename(lib, '.*') }

  ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3',
    :dbfile =>  "#{File.expand_path(File.dirname(__FILE__))}/db/#{Sinatra::Base.environment}.db"
  )

end