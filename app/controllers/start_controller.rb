class StartController < ApplicationController

  def keywords
    keywords = params.select {|k,v| /keyword_[1|2|3]/.match(k) && !v.empty? }
    if keywords.empty?
      @error = "Please enter at least 1 job or sector."
      render action: "index"
    else
      report = Report.new
      saved_keywords = keywords.values.map do |keyword|
        saved_keyword = Keyword.new(keyword: keyword)
        saved_keyword.occupations = create_occupations_for_keyword(keyword)
        saved_keyword.save
        saved_keyword
      end
      report.keywords = saved_keywords
      report.save
      redirect_to controller: :report, action: :select_soc_codes, guid: report.id
    end
  end

  # To be refactored once population is done via LMI For All
  private

  def create_occupations_for_keyword(keyword)
    occupation_1 = Occupation.create(
      soc_code: Random.new.rand(1000),
      title: "Occupation",
      description: "Description of the occupation in a longer version lorem ipsum"
    )
    occupation_2 = Occupation.create(
      soc_code: Random.new.rand(1000),
      title: "Other occupation",
      description: "Description of the other occupation in a longer version lorem ipsum"
    )
    [occupation_1, occupation_2]
  end

end
