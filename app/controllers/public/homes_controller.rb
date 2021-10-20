class Public::HomesController < ApplicationController
before_action :search_product, only: [:top]

def top
 
end

private

def search_product
  @p = Post.ransack(params[:q]) 
  @results = @p.result
end

end