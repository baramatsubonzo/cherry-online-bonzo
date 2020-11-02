require 'rails_helper'

RSpec.describe "ユーザー", type: :system do
  describe 'ログイン・ログアウト機能' do
    context '登録済みユーザーの場合' do
      let(:admin_user_1) { FactoryBot.create(:admin_user) }
      let(:user_1) { FactoryBot.create(:user) }
  
      before do
        visit login_path
        fill_in 'メールアドレス', with: login_user.email
        fill_in 'パスワード', with: login_user.password
      end

      context '管理者の場合' do
        let(:login_user) { admin_user_1 }
        before do
          click_button 'ログインする'
        end
        it '管理者トップページが表示される' do
          expect(page).to have_current_path admin_webbooks_path
        end
      end

      context 'ユーザーの場合' do
        let(:login_user) { user_1 }
        before do
          click_button 'ログインする'
        end
        it 'トップページが表示される' do
          expect(page).to have_current_path root_path
        end
      end
    end

    context '登録していないユーザーの場合' do
      before do
        visit login_path
        fill_in 'メールアドレス', with: "not_signup_user@sample.com"
        fill_in 'パスワード', with: "password"

        click_button 'ログインする'
      end

      it 'ログインページへリダイレクトされる' do
        expect(page).to have_current_path login_path
      end
    end
  end
end
