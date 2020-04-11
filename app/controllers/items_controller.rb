class ItemsController < ApplicationController
  before_action :set_item, only: [:show]
  def index
    @items = Item.where(status: false).limit(3).order("created_at DESC")
    @items_brand = Item.where(status: false).where(brand: "Off-White").limit(3).order("created_at DESC")
    @images = Image.all
    @categories = Category.all
  end

  
  def new
    @item = Item.new
    @item.images.new
    @category_parent_array = ["選択してください"]
      Category.where(ancestry: nil).each do |parent|
        @category_parent_array << parent.name
      end
  end

  def create
    @item = Item.new(item_params)
    respond_to do |format|
      format.html { redirect_to :root }
      format.json { render json: @item}
    end
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
    @images = @items.images
    @categories = Category.all
  end

  def confirm
  end

  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  private

  def item_params
    params.require(:item).permit(
                                  :name,
                                  :description,
                                  :brand,
                                  :state,
                                  :status,
                                  :postage,
                                  :shipping_date,
                                  :category,
                                  :price,
                                  item_images_attributes: [:src, :_destroy, :id]).marge(id: current_user.id,status: 0)
  end

  def category_params
    params.require(:category).permit(:name)
  end
  
  def set_item
    @items = Item.find(params[:id])
  end
end
