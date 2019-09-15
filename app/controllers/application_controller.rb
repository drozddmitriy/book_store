class ApplicationController < ActionController::Base
  include Pagy::Backend

  # add_flash_types :success, :danger, :info, :warning
end
