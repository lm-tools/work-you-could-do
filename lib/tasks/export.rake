namespace :export do
  desc "Export metrics to CSV"
  task metrics: :environment do
    print Scrapbook.metrics
  end
end
