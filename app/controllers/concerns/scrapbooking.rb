module Scrapbooking
  extend ActiveSupport::Concern

  included do
    helper_method :current_scrapbook
  end

  protected

  def current_scrapbook
    @current_scrapbook ||= Scrapbook.find_or_initialize_by(
      id: current_scrapbook_id
    )
  end

  def ensure_current_scrapbook
    current_scrapbook.save unless current_scrapbook.persisted?
  end

  private

  def current_scrapbook_id
    params[:scrapbook_id]
  end
end
