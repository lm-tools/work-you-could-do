class Action < ActiveRecord::Base
  ACTION_TYPES = {
    "cv": {
      "title": 'Tailor your CV',
      "notes": false
    },
    "research": {
      "title": 'Research skills needed',
      "notes": false
    },
    "apply": {
      "title": 'Apply for these sorts of jobs',
      "notes": false
    },
    "work_coach": {
      "title": 'Ask my work coach a question',
      "notes": false
    },
    "notes": {
      "title": 'My notes',
      "notes": true
    },
    "show_more": {
      "title": 'Show me more related roles',
      "notes": false
    }
  }

  def title
    ACTION_TYPES[action_type.to_sym][:title]
  end
end
