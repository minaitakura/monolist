class ItemsController < ApplicationController
  before_action :logged_in_user , except: [:show]
  before_action :set_item, only: [:show]

  def new
    if params[:q]
      begin
      response = Amazon::Ecs.item_search(params[:q] , 
                                  :search_index => 'All' , 
                                  :response_group => 'Medium' , 
                                  :country => 'jp')
      @amazon_items = response.items
      rescue Amazon::RequestError => e
        return render :js => "alert('#{e.message}')"
      end
    end
  end

  def show
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end
end
