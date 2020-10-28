require 'rails_helper'

RSpec.describe "カート", type: :system do
  describe 'すでにカートにある商品は追加できない' do
    context 'カートに商品がある場合' do
      it 'カートに追加できる' do
      end
    end

    context 'カートに商品がない場合' do
      it 'カートに追加できない' do
      end
    end
  end
end
