module ApplicationHelper
  def formatted_tasks(tasks)
    tasks.split(';').map(&:strip).map(&:capitalize)
  end
end
