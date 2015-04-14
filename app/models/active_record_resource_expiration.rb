module ActiveRecordResourceExpiration
  attr_accessor :_action_controller
  attr_accessor :_url_helpers

  def url_helpers
    @_url_helpers = Rails.application.routes.url_helpers
  end

  def _get_action_controller
    @_action_controller ||= ActionController::Base.new
  end

  def expire_fragment key, options = nil
    _get_action_controller.expire_fragment(key, options)
  end

  def expire_page options = {}
    _get_action_controller.expire_page(options)
  end


end
