module ScenarioData
  def scrapbook_id
    @scrapbook_id ||= Scrapbook.new_id
  end
end

World(ScenarioData)
