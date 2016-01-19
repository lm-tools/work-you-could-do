class Action < ActiveRecord::Base
  ACTION_TYPES = {
    interesting: {
      title: 'This sounds interesting'
    },
    work_coach: {
      title: 'Ask my work coach a question'
    },
    research: {
      title: 'Research skills or experience needed'
    },
    related: {
      title: 'Show me related roles'
    },
    cv: {
      title: 'Tailor my CV'
    },
    apply: {
      title: 'Apply for roles in this area'
    },
    no: {
      title: 'This role isn\'t interesting to me at the moment'
    },
    notes: {
      title: 'My notes'
    }
  }.freeze

  def title
    ACTION_TYPES.fetch(action_type.to_sym).fetch(:title)
  end
end
