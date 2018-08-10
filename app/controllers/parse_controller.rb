class ParseController < ApplicationController
    #skip_before_action :verify_authenticity_token, :only => [:scrape]
    def scrape
        ScraperWorker.new.perform(params[:keyword])
        redirect_to action: 'show_posts'
    end
    def show_posts
        posts= Post.all
        render json: posts
    end
end 