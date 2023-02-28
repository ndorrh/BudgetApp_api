class  Api::V1::MyTransactionsController < ApplicationController
  before_action :authenticate_user
  before_action :find_my_transaction, only: [:show, :update, :destroy]

  def index
    @my_transactions = MyTransaction.where(author: @current_user)
    render json: @my_transactions, status: 200
  end

   def show
    render json: @my_transaction, status: 200
   end

  def create
    @my_transaction = MyTransaction.new(transaction_params.except(:categories))
    @my_transaction.author = @current_user
    if @my_transaction.save
      render json: @my_transaction, status: 201
    else
      render json: {errors: @my_transaction.errors.full_messages}, status: 503
    end 
  end

  def update
    if @my_transaction.update(transaction_params)
      render json: @my_transaction, status: 200
    else
      render json: {errors: @my_transaction.errors.full_messages}, status: 503
    end
  end

  def destroy
    if @my_transaction.destroy
      render json: {message: "transaction deleted"}, status: 200
    else
      render json: {errors: @my_transaction.errors.full_messages}, status: 503
    end
  end

  private
  def transaction_params
    params.require(:my_transaction).permit( :name, :amount, categories: [])
  end

  def find_my_transaction
    @my_transaction = MyTransaction.find(params[:id])
  end
end
