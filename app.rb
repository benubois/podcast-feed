require "rubygems"
require "bundler"
Bundler.setup

require "sinatra"
require "uri"
require "time"
require "yaml"

require "./episode"

def shows
  @shows ||= YAML.load_file('config/shows.yml')
end

def build_episodes(show)
  Dir.glob("./public/shows/#{show}/*.mp3").reverse.each_with_object([]) do |file, array|
    array << Episode.new(file)
  end
end

get "/" do
  erb :index, locals: {
    shows: shows
  }
end

get "/show/:show" do
  content_type 'text/xml'
  episodes = build_episodes(params[:show])
  erb :show, locals: {
    show: shows.fetch(params[:show]),
    episodes: episodes,
    hostname: request.host
  }
end
