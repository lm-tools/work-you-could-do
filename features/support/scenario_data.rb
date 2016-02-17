module ScenarioData
  attr_accessor :current_search_query

  def scrapbook_id
    @scrapbook_id ||= Scrapbook.new_id
  end
end

World(ScenarioData)
