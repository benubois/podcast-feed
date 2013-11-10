require "rubygems"
require "bundler"
Bundler.setup

require "sinatra"
require "uri"
require "time"

require "./show"

get "/" do
  shows = []
  Dir.glob("./public/shows/*.mp3").reverse.each do |file|
    shows << Show.new(file)
  end
  erb :index, locals: {
    shows: shows,
    hostname: request.host
  }
end
