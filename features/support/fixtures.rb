# rubocop:disable Metrics/LineLength

module Fixtures
  SEARCH_RESULTS = {
    "library" => [
      { soc: 4135, title: "Library clerks and assistants", description: "Library clerks and assistants classify, sort and file publications, documents, audio-visual and computerised material in libraries and offices." },
      { soc: 2451, title: "Librarians", description: "Librarians appraise, obtain, index, collate and make available library acquisitions and organise and control other library services." },
      { soc: 4113, title: "Local government administrative occupations", description: "Job holders in this unit group undertake a variety of administrative and clerical duties in local government offices and departments." },
      { soc: 4112, title: "National government administrative occupations", description: "Job holders in this unit group undertake a variety of administrative and clerical duties in national government departments, and in local offices of national government departments." },
      { soc: 1259, title: "Managers and proprietors in other services n.e.c.", description: "Job holders in this unit group perform a variety of managerial tasks in other service industries not elsewhere classified in MINOR GROUP 125: Managers and Proprietors in Other Services." },
      { soc: 2426, title: "Business and related research professionals", description: "Business and related research professionals carry out a variety of research activities for the broadcast and print media, for the police and armed forces intelligence services, for national security agencies and in other non-scientific areas." },
      { soc: 8211, title: "Large goods vehicle drivers", description: "Large Goods Vehicle (LGV) drivers (formerly HGV drivers), collect, transport and deliver goods in rigid vehicles over 7.5 tonnes, articulated lorries and lorries pulling trailers." },
      { soc: 9233, title: "Cleaners and domestics", description: "Cleaners and domestics clean interiors of private houses, shops, hotels, schools, offices and other buildings." },
    ],
    "plumber" => [
      { soc: 5314, title: "Plumbers and heating and ventilating engineers", description: "Jobholders in this unit group assemble, install, maintain and repair plumbing fixtures, heating and ventilating systems and pipes and pipeline systems in commercial, residential and industrial premises and public buildings." },
      { soc: 9120, title: "Elementary construction occupations", description: "Job holders in this unit group perform a variety of general labouring and construction duties to assist building, civil engineering and related trades workers in the performance of their tasks." },
      { soc: 5242, title: "Telecommunications engineers", description: "Telecommunications engineers install, maintain and repair public and private telephone systems and maintain, test and repair telecommunications cables." },
    ],
  }.freeze

  def expected_search_results(query)
    SEARCH_RESULTS.fetch(query)
  end

  def work_related_search_query
    "library"
  end

  def other_work_related_search_query
    "plumber"
  end

  # TODO: this is using the tasks and additional_titles as imported via our
  #       own idiosyncratic formatting rules. This might need to be improved...
  def specific_search_result
    {
      soc: 4135,
      title: "Library clerks and assistants",
      description: "Library clerks and assistants classify, sort and file publications, documents, audio-visual and computerised material in libraries and offices.",
      tasks: "Sorts, catalogues and maintains library records\nLocates and retrieves material on request for borrowers\nIssues library material and records date of issue/ due date for return\nClassifies, labels and indexes new books\nPerforms simple repairs on old books.",
      qualifications: "There are no minimum academic requirements, although entrants usually possess GCSEs/S grades or A-Levels/H grades. Training is usually provided on-the-job. NVQs/ SVQs in Information and Library Services are available at Levels 2 and 3.",
      additional_titles: "Cutting, Press Agent; Archives Assistant; Bibliographic Assistant; Library Assistant; Resource, Learning Assistant; Services, Bibliographic Assistant; Library Attendant; Cuttings, Press Clerk; Library Clerk; Book Looker Out; Library Supervisor",
      week_hours: 38,
      week_pay: 470,
    }
  end
end

World(Fixtures)
