module FrontPages
  class BaseController < ApplicationController
    # TODO: remove this before_action after finish adding views
    before_action :authenticate_user!
  end
end
