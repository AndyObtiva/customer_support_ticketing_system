class ReportsController < ApplicationController
  def show
    @report = params[:id].constantize.new
    @report.generate
  end
end
