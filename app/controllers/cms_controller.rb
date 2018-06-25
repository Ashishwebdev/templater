class CmsController < ApplicationController
  # include ActionController::Rendering
  # include AbstractController::Helpers

  prepend_view_path ::SqlTemplate::Resolver.new()
  helper CmsHelper

  def respond
    render template: params[:page]
  end
end