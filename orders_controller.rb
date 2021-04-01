module Api
  module V1
    class OrdersController < ApplicationController

      # GET /orders
      # GET /orders.json
      def index
        @orders = Order.all
        
        render json: @orders, meta: { 'success' => true, 'count' => @orders.size}, root: 'data'
      end

      # GET /orders/1
      # GET /orders/1.json
      def show
        @order = Order.find(params[:id])

        render json: @order, meta: { 'success' => true }, root: 'data'
      end

      # POST /orders
      # POST /orders.json
      def create
        # O JSON será recebido aqui e será processado para salvar no banco.
        @order = Order.new(order_params)

        if @order.save
          render json: @order, meta: { 'success' => true }, root: 'data'
        else
          render json: @order, meta: { 'success' => false, 'errors' => @order.errors }, root: 'data'
        end
      end

      # PATCH/PUT /orders/1
      # PATCH/PUT /orders/1.json
      def update
        @order = Order.find(params[:id])

        if @order.update(order_params)
          render json: @order, meta: { 'success' => true }, root: 'data'
        else
          render json: @order, meta: { 'success' => false, 'errors' => @order.errors }, root: 'data'
        end
      end

      # DELETE /orders/1
      # DELETE /orders/1.json
      def destroy
        @order = Order.find(params[:id])
        
        if @order.destroy
          render json: @order, meta: { 'success' => true }, root: 'data'
        else
          render json: @order, meta: { 'success' => false, 'errors' => @order.errors }, root: 'data'
        end
      end

      private

      def order_params
        params.permit(:store_id, :date_created, :date_closed, :last_updated, :total_amount, :total_shipping, :total_amount_with_shipping, :paid_amount, :last_updated, :status, :buyer, :shipping, :payments, :order_items)
      end
    end
  end
end
