# frozen_string_literal: true

Rails.application.reloader.to_prepare do
  DeviseController.respond_to :html, :json if defined?(DeviseController)
end
