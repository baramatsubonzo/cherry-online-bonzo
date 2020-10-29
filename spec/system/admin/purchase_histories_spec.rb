require 'rails_helper'

RSpec.describe "Purchase", type: :system do
  describe '管理者の場合purchase#indexが表示される' do
    context '管理者の場合' do
      before do
        FactoryBot.create(:admin_user)
        visit login_path
        fill_in 'メールアドレス', with: 'admin@sample.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'

        visit admin_purchase_histories_path
      end
      it '購入履歴一覧が表示される' do
        expect(page).to have_current_path admin_purchase_histories_path
      end
    end

    context 'ユーザーの場合' do
      before do
        FactoryBot.create(:user)
        visit login_path
        fill_in 'メールアドレス', with: 'user_1@sample.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'

        visit admin_purchase_histories_path
      end
      it 'トップページにリダイレクトされる' do
        expect(page).to have_current_path root_path
      end
    end
  end
end
