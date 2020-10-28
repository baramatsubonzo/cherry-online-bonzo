require 'rails_helper'

RSpec.describe "ユーザー", type: :system do
  describe 'ログイン・ログアウト機能' do
    context '登録済みユーザーの場合' do
      context '管理者の場合' do
      end
      context 'ユーザーの場合' do
        it '' do
          visit login_path
          fill_in 'Email', with: 'test2@sample.com'
          fill_in 'Password', with: 'password'
          click_button 'ログインする'
          expect(page).to have_content 'ユーザーログイン'
        end
      end
    end
    # context '登録していないユーザーの場合' do
    #   it 'リダイレクト画面に飛ばされる' do
    #   end
    # end
  end
end
