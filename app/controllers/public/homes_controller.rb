class Public::HomesController < ApplicationController
before_action :search_product, only: [:top]

def top
  @posts = Post.order('id DESC').limit(5)
  @post_ranking_tohokus = Post.post_favorite.where(area_id: 1).order_rank
  @post_ranking_kantos = Post.post_favorite.where(area_id: 2).order_rank
  @post_ranking_tyubus = Post.post_favorite.where(area_id: 3).order_rank
  @post_ranking_kinkis = Post.post_favorite.where(area_id: 4).order_rank
  @post_ranking_tyugokus = Post.post_favorite.where(area_id: 5).order_rank
  @post_ranking_shikokus = Post.post_favorite.where(area_id: 6).order_rank
  @post_ranking_kyusyus = Post.post_favorite.where(area_id: 7).order_rank
end

private

def search_product
  @p = Post.ransack(params[:q]) 
  @results = @p.result
end

end