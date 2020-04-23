class HomeController < ApplicationController
  def index

    @images = Image.all
    @items = Item.all.order(id: "DESC")
    @search = Item.ransack(params[:q])
    @parents = Category.where(ancestry:nil)
    # t_table = Category.arel_table
    # @parents = Category.where(ancestry: nil).order(id: "ASC")
  end
end
