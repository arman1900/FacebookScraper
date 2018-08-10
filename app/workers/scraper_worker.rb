class ScraperWorker
  include Sidekiq::Worker
  def perform(keyword)
    require 'rake'
    require 'sidekiq/api'
    Sidekiq::RetrySet.new.clear
    Rake::Task.clear
    Facebookscraper101::Application.load_tasks
    Rake::Task['parse:facebook'].invoke(keyword)
  end
end
