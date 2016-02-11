module Fixtures
  def work_related_search_term
    "library"
  end

  def expected_search_results
    [
      { soc: "4135", title: "Library clerks and assistants" },
      { soc: "2451", title: "Librarians" },
      { soc: "4113", title: "Local government administrative occupations" },
      { soc: "4112", title: "National government administrative occupations" },
      { soc: "1259", title: "Managers and proprietors in other services" },
      { soc: "2426", title: "Business and related research professionals" },
      { soc: "8211", title: "Large goods vehicle drivers" },
      { soc: "9233", title: "Cleaners and domestics" },
    ]
  end
end

World(Fixtures)
