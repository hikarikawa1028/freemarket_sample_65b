class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
    @items = Item.where(id: params[:id])
    @item = Item.find(params[:id])
    @images = @item.images
    # binding.pry
    @comment = Comment.new
    if @comment.save
      redirect_to root_path
    else
      render :show
    end
    @comments = @item.comments.includes(:user)
  end

  def confirm
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :brand, :state, :status, :postage, :shipping_date, :category)
  end
  
end
