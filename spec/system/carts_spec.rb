require 'rails_helper'

RSpec.describe "カート", type: :system do
  describe 'エンドユーザーは購入したいWebブックをカートに追加できる' do
    context 'カートに商品がない場合' do
      let(:user_a) { FactoryBot.create(:user) }
      let!(:webbook_a) { FactoryBot.create(:webbook) }
      let!(:cart) { FactoryBot.create(:cart, user: user_a) }
      

      before do
        visit login_path
        fill_in 'メールアドレス', with: user_a.email
        fill_in 'パスワード', with: user_a.password
        click_button 'ログインする'

        visit webbook_path(webbook_a.id)
        click_button 'カートに入れる'
      end
      it 'カートに商品が追加されている' do
        expect(page).to have_current_path cart_path(user_a.cart.id)
      end
    end

    context 'すでにカートに商品がある場合' do
      let(:user_a) { FactoryBot.create(:user) }
      let(:webbook_a) { FactoryBot.create(:webbook) }
      let(:cart) { FactoryBot.create(:cart, user: user_a) }
      let!(:cart_webbook) { FactoryBot.create(:cart_webbook, cart: cart, webbook: webbook_a) }

      before do
        visit login_path
        fill_in 'メールアドレス', with: user_a.email
        fill_in 'パスワード', with: user_a.password
        click_button 'ログインする'

        visit webbook_path(webbook_a.id)
        click_button 'カートに入れる'
      end
      it 'カートに商品が追加されていない' do
        expect(page).to have_current_path root_path
      end
    end
  end

  describe 'エンドユーザーはカートからWebブックを削除できる' do
    let(:user_a) { FactoryBot.create(:user) }
    let(:webbook_a) { FactoryBot.create(:webbook) }
    let(:cart) { FactoryBot.create(:cart, user: user_a) }
    let!(:cart_webbook) { FactoryBot.create(:cart_webbook, cart: cart, webbook: webbook_a) }

    before do
      visit login_path
      fill_in 'メールアドレス', with: user_a.email
      fill_in 'パスワード', with: user_a.password
      click_button 'ログインする'

      visit cart_path(user_a.cart.id)
      click_link '削除'
    end
    it 'カートから商品が削除される' do
      expect(page.driver.browser.switch_to.alert.text).to eq "カートから削除してよろしいですか？"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_current_path cart_path(user_a.cart.id)
    end
  end
end
