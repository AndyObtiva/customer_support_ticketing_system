class ReportsController < ApplicationController
  before_action :authenticate_user!
  def show
    @report = params[:id].constantize.new
    @report.generate
  end
end
