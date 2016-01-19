class Action < ActiveRecord::Base
  ACTION_TYPES = [
    {
      key: 'interesting',
      title: 'This sounds interesting'
    },
    {
      key: 'work_coach',
      title: 'Ask my work coach a question'
    },
    {
      key: 'research',
      title: 'Research skills or experience needed'
    },
    {
      key: 'related',
      title: 'Show me related roles'
    },
    {
      key: 'cv',
      title: 'Tailor my CV'
    },
    {
      key: 'apply',
      title: 'Apply for roles in this area'
    },
    {
      key: 'no',
      title: 'This role isn\'t interesting to me at the moment'
    },
    {
      key: 'notes',
      title: 'My notes'
    }
  ].freeze

  def title
    ACTION_TYPES.find { |e| e[:key] == action_type }.fetch(:title)
  end
end
