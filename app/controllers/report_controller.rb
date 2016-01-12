class ReportController < ApplicationController
  def select_soc_codes
    report = Report.find(params[:guid])
    @keywords = report.keywords.map do |keyword|
      {
        "title": keyword.keyword,
        "results": keyword.occupations.map(&:to_hash)
      }
    end
  end
end
