require "rubygems"
require "bundler"
Bundler.setup

require "sinatra"
require "uri"
require "time"

require "./show"

get "/" do
  erb :index, locals: {
    shows: get_shows,
    hostname: request.host
  }
end

def get_shows
  shows = []
  Dir.glob("./public/shows/*.mp3").reverse.each do |file|
    shows << Show.new(file)
  end
  shows
end

