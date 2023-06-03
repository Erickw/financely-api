module Api
  module V1
    class UsersController < ApplicationController
      def index
        @users = User.order('created_at DESC');

        if @users
          render json: @users, :include => [:cards], status: :ok
        else
          render plain: "404 Not Found", status: 404
        end
      end

      def show
          @user = User.find_by(firebase_id: params[:id])
          render json: @user, :include => [:cards], status: :ok
      rescue ActiveRecord::RecordNotFound
          render plain: "404 Not Found", status: 404
      end

      def create
        @user = User.new(user_params)

        if @user.save
          render json: {message:'Saved User'}, status: :ok
        else
          render json: {message:'User not saved'}, status: :unprocessable_entity
        end
      end

      def destroy
        @user = User.find_by(firebase_id: params[:id])
				@user.destroy
				render json: {message:'Deleted User'}, status: :ok
      rescue ActiveRecord::RecordNotFound
        render plain: "404 Not Found", status: 404
      end

      def update
        @user = User.find_by(firebase_id: params[:id])

        if @user.update(user_params)
          render json: {message:'Updated User'}, status: :ok
        else
          render json: {message:'User not update'}, status: :unprocessable_entity
        end

      rescue ActiveRecord::RecordNotFound
        render plain: "404 Not Found", status: 404
      end

      private

      def user_params
        params.permit(:name, :email, :avatar_url, :firebase_id)
      end
    end
  end
end
