class StartController < ApplicationController

  def keywords
    keywords = params.select {|k,v| /keyword_[1|2|3]/.match(k) && !v.empty? }
    if keywords.empty?
      @error = "Please enter at least 1 job or sector."
      render action: "index"
    else
      report = Report.new
      saved_keywords = keywords.values.map do |keyword|
        Keyword.create(keyword: keyword)
      end
      report.keywords = saved_keywords
      report.save
      redirect_to controller: :report, action: :select_soc_codes, guid: report.id
    end
  end

end
