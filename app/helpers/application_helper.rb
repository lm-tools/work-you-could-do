module ApplicationHelper
  def formatted_tasks(tasks)
    tasks.split(";").map(&:strip).map(&:capitalize)
  end

  def pluralize_without_count(count, noun)
    count == 1 ? noun : noun.to_s.pluralize
  end
end
