require 'rails_helper'

RSpec.describe 'Webbookを購入する', type: :system do
  describe 'ユーザーはwebbookを購入できる' do
    context '購入履歴にWebbookがない場合' do
      let(:user_a) { FactoryBot.create(:user) }
      let(:webbook_a) { FactoryBot.create(:webbook) }
      let(:webbook_b) { FactoryBot.create(:webbook, title: '履歴にある本') }
      let(:cart) { FactoryBot.create(:cart, user: user_a) }
      let!(:cart_webbook) { FactoryBot.create(:cart_webbook, cart: cart, webbook: webbook_a) }

      let(:purchase_history) { FactoryBot.create(:purchase_history, user: user_a) }
      let!(:purchase_history_webbook) { FactoryBot.create(:purchase_history_webbook, purchase_history: purchase_history, webbook: webbook_b) }

      before do
        FactoryBot.create(:page, webbook_id: webbook_a.id)
        FactoryBot.create(:page, webbook_id: webbook_b.id)
        visit login_path
        fill_in 'メールアドレス', with: 'user_1@sample.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'

        visit cart_path(user_a.cart.id)
        click_button '購入する'
        sleep(2)

        Capybara.within_frame 'stripe_checkout_app' do
          fill_in 'カード番号', with: '4242424242424242'
          fill_in '有効期限', with: '11/22'
          fill_in 'CVC', with: '123'

          click_button 'を支払う'
          sleep(3)
        end
      end

      it 'マイページが表示される' do
        expect(page).to have_current_path mypage_path
      end

      # it 'purchase_history_webbooksにレコードが増える' do
      # end

      it '購入完了のメールが一件作成される' do
        expect(ActionMailer::Base.deliveries.last.to.count).to eq 1
      end
    end

    context '購入履歴にWebbookがある場合' do
      let(:user_a) { FactoryBot.create(:user) }
      let(:webbook_a) { FactoryBot.create(:webbook) }
      let(:cart) { FactoryBot.create(:cart, user: user_a) }
      let!(:cart_webbook) { FactoryBot.create(:cart_webbook, cart: cart, webbook: webbook_a) }

      let(:purchase_history) { FactoryBot.create(:purchase_history, user: user_a) }
      let!(:purchase_history_webbook) { FactoryBot.create(:purchase_history_webbook, purchase_history: purchase_history, webbook: webbook_a) }

      before do
        visit login_path
        fill_in 'メールアドレス', with: 'user_1@sample.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'

        visit cart_path(user_a.cart.id)
        click_button '購入する'
        sleep(2)

        Capybara.within_frame 'stripe_checkout_app' do
          fill_in 'カード番号', with: '4242424242424242'
          fill_in '有効期限', with: '11/22'
          fill_in 'CVC', with: '123'

          click_button 'を支払う'
          sleep(3)
        end
      end

      it 'ユーザートップページへいく' do
        expect(page).to have_current_path root_path
      end
    end
  end

  describe '発売日がまだ来ていないWebブックは購入できない' do
    let(:user_a) { FactoryBot.create(:user) }
    let(:webbook_a) { FactoryBot.create(:webbook, release_date: Date.today + 1) }
    let(:webbook_b) { FactoryBot.create(:webbook, title: '履歴にある本') }
    let(:cart) { FactoryBot.create(:cart, user: user_a) }
    let!(:cart_webbook) { FactoryBot.create(:cart_webbook, cart: cart, webbook: webbook_a) }
    let(:purchase_history) { FactoryBot.create(:purchase_history, user: user_a) }
    let!(:purchase_history_webbook) { FactoryBot.create(:purchase_history_webbook, purchase_history: purchase_history, webbook: webbook_b) }

    context '発売日が今日より後の場合(購入できない)' do
      before do
        FactoryBot.create(:page, webbook_id: webbook_a.id)
        FactoryBot.create(:page, webbook_id: webbook_b.id)
        visit login_path
        fill_in 'メールアドレス', with: 'user_1@sample.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'

        visit cart_path(user_a.cart.id)
        click_button '購入する'
        sleep(2)

        Capybara.within_frame 'stripe_checkout_app' do
          fill_in 'カード番号', with: '4242424242424242'
          fill_in '有効期限', with: '11/22'
          fill_in 'CVC', with: '123'

          click_button 'を支払う'
          sleep(3)
        end
      end

      it '商品が購入できず、アラートが表示されている' do
        expect(page).to have_content '発売日前の商品です'
      end
    end
  end
end
