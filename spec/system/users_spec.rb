require 'rails_helper'

RSpec.describe "ユーザー", type: :system do
  describe 'ログイン・ログアウト機能' do
    context '登録済みユーザーの場合' do
      context '管理者の場合' do
        before do
          FactoryBot.create(:admin_user)
          visit login_path
          fill_in 'メールアドレス', with: 'admin@sample.com'
          fill_in 'パスワード', with: 'password'
          click_button 'ログインする'
        end
        it '管理者トップページが表示される' do
          expect(page).to have_content '管理者用Top Page'
        end
      end

      context 'ユーザーの場合' do
        before do
          FactoryBot.create(:user)
          visit login_path
          fill_in 'メールアドレス', with: 'user_1@sample.com'
          fill_in 'パスワード', with: 'password'
          click_button 'ログインする'
        end
        it 'トップページが表示される' do
          expect(page).to have_content 'Top Page'
        end
      end
    end

    context '登録していないユーザーの場合' do
      before do
        visit login_path
        fill_in 'メールアドレス', with: 'user_1@sample.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'
      end

      it 'ログインページへリダイレクトされる' do
        expect(page).to have_content 'ユーザーログイン'
      end
    end
  end
end
