class ScraperWorker
  include Sidekiq::Worker

  def perform(keyword)
    require 'rake'
    Rake::Task.clear
    Facebookscraper101::Application.load_tasks
    Rake::Task['parse:facebook'].invoke(keyword)
  end
end
