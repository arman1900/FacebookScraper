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
    def show_posts
        posts= Post.all
        render json: posts
    end
end 