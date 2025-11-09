class PagesController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    # página principal
  end
end