class Action < ActiveRecord::Base
  ACTION_TYPES = {
    cv: {
      title: 'Tailor your CV'
    },
    research: {
      title: 'Research skills needed'
    },
    apply: {
      title: 'Apply for these sorts of jobs'
    },
    work_coach: {
      title: 'Ask my work coach a question'
    },
    notes: {
      title: 'My notes'
    },
    show_more: {
      title: 'Show me more related roles'
    }
  }.freeze

  def title
    ACTION_TYPES[action_type.to_sym][:title]
  end
end
