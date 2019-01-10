class Cms::Admin::BaseController < AdminController
  include RailsRoleController
  before_action :debug_csp

  def current_manager
    current_user&.manager
  end

  def debug_csp
  end

end
