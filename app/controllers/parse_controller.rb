class ParseController < ApplicationController
    skip_before_action :verify_authenticity_token, :only => [:scrape]
    
    def scrape
        require 'rake'
    require 'sidekiq/api'
    
    Rake::Task.clear
    Facebookscraper101::Application.load_tasks
        Rake::Task['parse:facebook'].invoke(params[:keyword])
        redirect_to action: 'show_posts'
    end
    def sent_flask
        require 'uri'
        require 'net/http'
        require 'json'
#=begin
        url = URI("https://sent-flask.herokuapp.com/predict")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Post.new(url.path, 'Content-Type' => 'application/json')
        request.body = Post.all.to_json
        response = http.request(request)
        response.read_body.gsub!(/\\u([0-9a-z]{4})/) {|s| [$1.to_i(16)].pack("U")}
        render json: response.read_body
#=end
    end
    def show_posts
        posts= Post.all
        render json: posts
    end
end 