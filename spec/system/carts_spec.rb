require 'rails_helper'

RSpec.describe 'カート', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:webbook_a) { FactoryBot.create(:webbook) }
  let!(:cart) { FactoryBot.create(:cart, user: user) }

  before do
    visit login_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログインする'
  end

  describe 'エンドユーザーは購入したいWebブックをカートに追加できる' do
    context 'カートに商品がない場合' do
      before do
        visit webbook_path(webbook_a.id)
        click_button 'カートに入れる'
      end

      it 'カートに商品が追加されている' do
        expect(page).to have_current_path cart_path(user.cart.id)
      end
    end

    context 'すでにカートに商品がある場合' do
      let!(:cart_webbook) { FactoryBot.create(:cart_webbook, cart: cart, webbook: webbook_a) }

      before do
        visit webbook_path(webbook_a.id)
        click_button 'カートに入れる'
      end

      it 'カートに商品が追加されていない' do
        expect(page).to have_content 'すでにカートにある商品です'
        expect(page).to have_current_path root_path
      end
    end
  end

  describe 'エンドユーザーはカートからWebブックを削除できる' do
    let!(:cart_webbook) { FactoryBot.create(:cart_webbook, cart: cart, webbook: webbook_a) }

    before do
      visit cart_path(user.cart.id)
      click_link '削除'
    end

    it 'カートから商品が削除される' do
      expect(page.driver.browser.switch_to.alert.text).to eq 'カートから削除してよろしいですか？'
      page.driver.browser.switch_to.alert.accept

      expect(page).to have_current_path cart_path(user.cart.id)
    end
  end
end
