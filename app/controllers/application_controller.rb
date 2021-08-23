class ApplicationController < Sinatra::Base
  set default_content_type: "application/json"
  
  get '/bakeries' do
    bakeries = Bakery.all
    bakeries.to_json
  end
  
  get '/bakeries/:id' do
    bakery = Bakery.find(params[:id])
    bakery.to_json(include: :baked_goods)
  end

  patch '/bakeries/:id' do
    find_bakery = Bakery.find(params[:id])
    find_bakery.update(baked_params)
    find_bakery.to_json
  end

  get '/baked_goods/by_price' do
    # see the BakedGood class for the  method definition of `.by_price`
    baked_goods = BakedGood.by_price
    baked_goods.to_json
  end

  get '/baked_goods/most_expensive' do
    # see the BakedGood class for the  method definition of `.by_price`
    baked_good = BakedGood.by_price.first
    baked_good.to_json
  end

  post '/baked_goods' do
    new_baked_good = BakedGood.create(baked_params)
    new_baked_good.to_json
  end

  delete '/baked_goods/:id' do
    find_goods = BakedGood.find(params[:id])
    find_goods.destroy
    find_goods.to_json
  end

end

private 

def baked_params
  allowed_params = %w(name price bakery_id)
  params.select {|param,value| allowed_params.include?(param)}
end
