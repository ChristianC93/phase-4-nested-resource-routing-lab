class ItemsController < ApplicationController

  def index
    if params[:user_id]
      if User.find_by(id: params[:user_id])
        user = User.find_by(id: params[:user_id])
        items = user.items
      else
        return render json: user, status: :not_found
      end
    else
      items = Item.all
    end
    render json: items, include: :user 
  end

  def show
    item = Item.find_by(id: params[:id])
    if item
      item
    else
      return render json: item, status: :not_found
    end
    render json: item, include: :user
  end

  def create
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      item = user.items.create(item_params)
    else
      item = Item.create(item_params)
    end
    render json: item, include: :user, status: :created
  end

  private

  def item_params
    params.permit(:name, :description, :price)
  end
end
