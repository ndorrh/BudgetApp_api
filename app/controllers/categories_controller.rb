class CategoriesController < ApplicationController
   before_action :authenticate_user
  before_action :find_category, only: [:show, :update, :destroy]

  def index
    @categories = Category.all
    render json: @categories, status: 200
  end

   def show
    render json: @category, status: 200
   end

  def create
    @category = Category.new(category_params)
    if @category.save
      render json: @category, status: 201
    else
      render json: {errors: @category.errors.full_messages}, status: 503
    end 
  end

  def update
    if @category.update(category_params)
      render json: @category, status: 200
    else
      render json: {errors: @category.errors.full_messages}, status: 503
    end
  end

  def destroy
    if @category.destroy
      render json: {message: "category deleted"}, status: 200
    else
      render json: {errors: @category.errors.full_messages}, status: 503
    end
  end

  private
  def category_params
    params.require(:category).permit( :name, :icon)
  end

  def find_category
    @category = Category.find(params[:id])
  end
end
