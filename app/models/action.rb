class Action < ActiveRecord::Base
  ACTION_TYPES = {
    "cv": {
      "title": "Review your CV",
      "description": "Description of the CV action"
    },
    "search": {
      "title": "Search for jobs",
      "description": "Description of the search action"
    }
  }

  def title
    ACTION_TYPES[action_type.to_sym][:title]
  end

  def description
    ACTION_TYPES[action_type.to_sym][:description]
  end
end
