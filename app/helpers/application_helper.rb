module ApplicationHelper
  def formatted_tasks(tasks)
    tasks.split(';').map(&:strip).map(&:capitalize)
  end

  def pluralize_without_count(count, noun, text = nil)
    count == 1 ? "#{noun}#{text}" : "#{noun.pluralize}#{text}"
  end
end
