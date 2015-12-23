class ApplicationController < ActionController::Base
  around_filter :config_timezone

  def config_timezone(&block)
    timezone = "America/Argentina/Buenos_Aires"
    Time.use_zone(timezone, &block)
  end
end
