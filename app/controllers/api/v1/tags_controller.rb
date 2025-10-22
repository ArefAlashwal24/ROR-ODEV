module Api
  module V1
    class TagsController < ApplicationController
      before_action :set_tag, only: %i[show update destroy]

      def index; render json: Tag.all; end
      def show;  render json: @tag.as_json(include: { posts: { only: %i[id title] } }); end

      def create
        tag = Tag.new(tag_params)
        if tag.save then render json: tag, status: :created
        else render json: { errors: tag.errors.full_messages }, status: :unprocessable_entity end
      end

      def update
        if @tag.update(tag_params) then render json: @tag
        else render json: { errors: @tag.errors.full_messages }, status: :unprocessable_entity end
      end

      def destroy
        @tag.destroy
        head :no_content
      end

      private
      def set_tag; @tag = Tag.find(params[:id]); end
      def tag_params; params.require(:tag).permit(:name); end
    end
  end
end
