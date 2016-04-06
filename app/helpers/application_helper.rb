module ApplicationHelper
  def formatted_tasks(tasks)
    tasks.split(";").map(&:strip).map(&:capitalize)
  end

  def pluralize_without_count(count, noun)
    count == 1 ? noun : noun.to_s.pluralize
  end

  def show_current_scrapbook_link?
    current_scrapbook.present? &&
      request.path != scrapbook_path(current_scrapbook) &&
      current_scrapbook.occupations.any?
  end

  def cookies_path
    if current_scrapbook.present?
      scrapbook_cookies_path(current_scrapbook)
    else
      super
    end
  end
end
