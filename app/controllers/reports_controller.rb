class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_support_agent!
  def show
    @report = params[:id].constantize.new
    @report.generate
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "show", header: { right: '[page] of [topage]' }
      end
    end
  end
end
