module Api
  module V1
    class CardsController < ApplicationController
      before_action :current_user, only: [:show, :create, :update]

      def index
        @cards = Card.order('created_at DESC');

        if @cards
          render json: @cards, :include => [:user, :bills], status: :ok
        else
          render plain: "404 Not Found", status: 404
        end
      end

      def show
        @card = Card.find(params[:id])
        render json: @card, :include => [:user, :bills], status: :ok
      rescue ActiveRecord::RecordNotFound
        render plain: "404 Not Found", status: 404
      end

      def create
        @card = Card.new(card_params)

        current_user.cards << @card
        current_user.save!

        if @card.save
          render json: {message:'Saved Card', data: @card}, status: :ok
        else
          render json: {message:'Card not saved', data: @card}, status: :unprocessable_entity
        end
      end

      def destroy
        @card = Card.find(params[:id])
				@card.destroy
				render json: {message:'Deleted Card', data: @card}, status: :ok
      rescue ActiveRecord::RecordNotFound
        render plain: "404 Not Found", status: 404
      end

      def update
        @card = Card.find(params[:id])

        if @card.update(card_params)
          render json: {message:'Updated Card', data: @card}, status: :ok
        else
          render json: {message:'Card not update', data: @card.erros}, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render plain: "404 Not Found", status: 404
      end

      private

      def card_params
        params.permit(:number, :name, :limit, :logo_url)
      end

      def current_user
        User.find_by(firebase_id: params[:user_id])
      end
    end
  end
end
