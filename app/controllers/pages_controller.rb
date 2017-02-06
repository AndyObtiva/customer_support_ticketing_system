class PagesController < ApplicationController
  include HighVoltage::StaticPage

  before_filter :authenticate_user!
end
