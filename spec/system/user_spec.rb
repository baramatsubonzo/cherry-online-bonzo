require 'rails_helper'

RSpec.describe "ユーザー", type: :system do
  describe 'ログイン・ログアウト機能' do
    context '登録済みユーザーの場合' do
      context '管理者の場合' do
        before do
          # 管理者ユーザーを作成しておく
          FactoryBot.create(:admin_user)
          # 管理者ユーザーでログインしておく
          visit login_path
          fill_in 'Email', with: 'admin@sample.com'
          fill_in 'Password', with: 'password'
          click_button 'ログインする'
        end
        it '管理者トップページが表示される' do
          expect(page).to have_content '管理者トップページ'
        end
      end
      context '管理者の場合' do
        # before do
        #   # 管理者ユーザーを作成しておく
        #   FactoryBot.create(:user)
        #   # 管理者ユーザーでログインしておく
        #   visit login_path
        #   fill_in 'Email', with: 'sample1@sample.com'
        #   fill_in 'Password', with: 'password'
        #   click_button 'ログインする'
        # end
        # it '管理者トップページが表示される' do
        #   binding.pry
        #   expect(page).to have_content 'Top Page'
        # end
      end
    end
    context '登録していないユーザーの場合' do
      it 'リダイレクト画面に飛ばされる' do
      end
    end
  end
end
