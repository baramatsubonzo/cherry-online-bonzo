require 'rails_helper'

RSpec.describe "Purchase", type: :system do
  describe '管理者の場合purchase#indexが表示される' do
    before do
      visit login_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_button 'ログインする'

      visit admin_purchase_histories_path
    end

    context '管理者の場合' do
      let(:login_user) { FactoryBot.create(:admin_user) }

      it '購入履歴一覧が表示される' do
        expect(page).to have_current_path admin_purchase_histories_path
      end
    end

    context 'ユーザーの場合' do
      let(:login_user) { FactoryBot.create(:user) }

      it 'トップページにリダイレクトされる' do
        expect(page).to have_current_path root_path
      end
    end
  end
end
