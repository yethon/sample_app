class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hello
    render html: "Testing... testing... 1 2 3..."
  end
end
