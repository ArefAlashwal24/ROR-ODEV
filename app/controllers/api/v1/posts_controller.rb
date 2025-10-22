module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: %i[show update destroy add_tag remove_tag]

      def index
        posts = Post.includes(:user).all
        render json: posts.as_json(include: { user: { only: %i[id name email] } })
      end

      def show
        render json: @post.as_json(include: {
          user: { only: %i[id name email] },
          comments: { include: { user: { only: %i[id name] } } }
        })
      end

      def create
        post = Post.new(post_params)
        if post.save then render json: post, status: :created
        else render json: { errors: post.errors.full_messages }, status: :unprocessable_entity end
      end

      def update
        if @post.update(post_params) then render json: @post
        else render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity end
      end

      def destroy
        @post.destroy
        head :no_content
      end

      # (Will work after Tags models exist)
      def add_tag
        tag = Tag.find(params[:tag_id])
        @post.tags << tag unless @post.tags.include?(tag)
        render json: @post.tags
      end

      def remove_tag
        tag = Tag.find(params[:tag_id])
        @post.tags.destroy(tag)
        head :no_content
      end

      private
      def set_post; @post = Post.find(params[:id]); end
      def post_params; params.require(:post).permit(:title, :body, :user_id); end
    end
  end
end
