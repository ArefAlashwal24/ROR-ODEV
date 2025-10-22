module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_comment, only: %i[show update destroy]

      def index
        if params[:post_id]
          comments = Comment.where(post_id: params[:post_id]).includes(:user)
          render json: comments.as_json(include: { user: { only: %i[id name] } })
        else
          render json: Comment.all
        end
      end

      def show; render json: @comment; end

      def create
        comment = Comment.new(comment_params.merge(post_id: params[:post_id]))
        if comment.save then render json: comment, status: :created
        else render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity end
      end

      def update
        if @comment.update(comment_params) then render json: @comment
        else render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity end
      end

      def destroy
        @comment.destroy
        head :no_content
      end

      private
      def set_comment; @comment = Comment.find(params[:id]); end
      def comment_params; params.require(:comment).permit(:body, :user_id, :post_id); end
    end
  end
end
