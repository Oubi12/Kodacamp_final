class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = 'Category added.'
      redirect_to categories_path
    else
      flash[:alert] = 'Category saving failed.'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Category updated.'
      redirect_to categories_path
    else
      flash[:alert] = 'Category update failed.'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = 'Category destroyed successfully'
    else
      flash[:alert] = @category.errors.full_messages.join(', ')
    end
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end