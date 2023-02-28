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

    if params[:categories].length <1
      render json: {errors: "You must select at least one category"}, status: 503
    else
    
      create_or_delete_category_transactions(@my_transaction, params[:categories])
    if @my_transaction.save
      render json: @my_transaction, status: 201
    else
      render json: {errors: @my_transaction.errors.full_messages}, status: 503
    end 
    end
  end

  def update
     create_or_delete_category_transactions(@my_transaction, params[:categories])
    if @my_transaction.update(transaction_params.except(:categories))
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
   def create_or_delete_category_transactions(my_transaction, categories)
    my_transaction.category_transactions.destroy_all
    categories.each do |category_id|
      CategoryTransaction.create(my_transaction:, category: Category.find(category_id.to_i)) if category_id != ''
    end
   end

  def transaction_params
    params.require(:my_transaction).permit( :name, :amount, categories: [])
  end

  def find_my_transaction
    @my_transaction = MyTransaction.find(params[:id])
  end
end
