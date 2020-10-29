require 'rails_helper'

RSpec.describe "カート", type: :system do
  describe 'エンドユーザーは購入したいWebブックをカートに追加できる' do
    context 'カートに商品がない場合' do
      it 'カートに商品が追加されている' do
      end
    end

    context 'すでにカートに商品がある場合' do
      it 'カートに商品が追加されていない' do
      end
    end
  end
end
