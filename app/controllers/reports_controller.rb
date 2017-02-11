class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_support_agent!
  def show
    @report = params[:id].constantize.new
    @report.generate
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "show", layout: 'pdf'
      end
    end
  end
end
