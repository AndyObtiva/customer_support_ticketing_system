class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_back(fallback_location: ticket_path(@comment.ticket), notice: 'Comment was successfully created.') }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to(ticket_path(comment_params[:ticket_id])) }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body, :ticket_id, :user_id)
    end
end
