# frozen_string_literal: true
﻿module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: %i[show update destroy]

      def index() = render(json: User.all)
      def show() = render(json: @user)

      def create
        user = User.new(user_params)
        if user.save then render json: user, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity 
        end
      end

      def update
        if @user.update(user_params) then render json: @user
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity 
        end
      end

      def destroy
        @user.destroy
        head :no_content
      end

      private

      def set_user() = @user = User.find(params[:id])
      def user_params() = params.require(:user).permit(:name, :email)
    end
  end
end
