module Api
  module V1
    class BillsController < ApplicationController
      before_action :current_card, only: [:show, :create, :update]

      def index
        @bills = Bill.order('created_at DESC');

        if @bills
          render json: @bills, :include => [:card], status: :ok
        else
          render plain: "404 Not Found", status: 404
        end
      end

      def show
        @bill = Bill.find(params[:id])
        render json: @bill, :include => [:card], status: :ok
      rescue ActiveRecord::RecordNotFound
        render plain: "404 Not Found", status: 404
      end

      def create
        @bill = Bill.new(bill_params)

        current_card.bills << @bill
        current_card.save!

        if @bill.save
          render json: {message:'Saved Bill', data: @bill}, status: :ok
        else
          render json: {message:'Bill not saved', data: @bill}, status: :unprocessable_entity
        end
      end

      def destroy
        @bill = Bill.find(params[:id])
				@bill.destroy
				render json: {message:'Deleted Bill', data: @bill}, status: :ok
      rescue ActiveRecord::RecordNotFound
        render plain: "404 Not Found", status: 404
      end

      def update
        @bill = Bill.find(params[:id])

        if @bill.update(bill_params)
          render json: {message:'Updated Bill', data: @bill}, status: :ok
        else
          render json: {message:'Bill not update', data: @bill.erros}, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render plain: "404 Not Found", status: 404
      end

      private

      def bill_params
        params.permit(:value, :expire_date)
      end

      def current_card
        Card.find(params[:card_id])
      end
    end
  end
end
