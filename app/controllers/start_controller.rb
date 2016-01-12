class StartController < ApplicationController

  def keywords
    keywords = params.select {|k,v| /keyword_[1|2|3]/.match(k) && !v.empty? }
    if keywords.empty?
      @error = "Please enter at least 1 job or sector."
      render action: "index"
    else
      report = Report.generate_report_for_keywords(keywords.values)
      redirect_to controller: :report, action: :select_soc_codes, guid: report.id
    end
  end

end
