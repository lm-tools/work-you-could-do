class ReportController < ApplicationController
  def select_soc_codes
    report = Report.find(params[:guid])
    @keywords = report.keywords.map do |keyword|
      {
        "title": keyword.keyword,
        "results": [
          {
            "title": "Cooks",
            "description": "Cooks prepare, season and cook food, often using pre-prepared
            ingredients, in clubs, private households, fast food outlets, shops selling food
            cooked on the premises and the catering departments and canteens of other establishments."
          },
          {
            "title": "Housekeepers and related occupations",
            "description": "Housekeepers and related workers perform domestic cleaning and other
            housekeeping tasks within private households, hotels, schools, hostels
            and other non-private households."
          },
        ]
      }
    end
  end
end
