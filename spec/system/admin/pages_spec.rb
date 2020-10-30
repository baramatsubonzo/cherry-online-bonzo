require 'rails_helper'

RSpec.describe "Admin#Page", type: :system do
  describe 'page#new' do
    describe '管理者の場合page#newが表示される' do
    let(:webbook_a){FactoryBot.create(:webbook)}
      context '管理者の場合' do        
        before do
          FactoryBot.create(:admin_user)
          visit login_path
          fill_in 'メールアドレス', with: 'admin@sample.com'
          fill_in 'パスワード', with: 'password'
          click_button 'ログインする'
  
          visit new_admin_webbook_path
        end
        it 'page作成ページが表示される' do
          expect(page).to have_current_path new_admin_webbook_path
        end

      end

      context 'ユーザーの場合' do
        before do
          FactoryBot.create(:user)
          visit login_path
          fill_in 'メールアドレス', with: 'user_1@sample.com'
          fill_in 'パスワード', with: 'password'
          click_button 'ログインする'
  
          visit new_admin_webbook_page_path(webbook_a.id)
        end
        it 'トップページへリダイレクトされる' do
          expect(page).to have_current_path root_path
        end
      end
    end

    describe 'pageを作成することができる' do
      let(:webbook_a){FactoryBot.create(:webbook)}
      context 'pageが追加される' do
        before do
          FactoryBot.create(:admin_user)
          FactoryBot.create(:page, webbook_id: webbook_a.id)
          visit login_path
          fill_in 'メールアドレス', with: 'admin@sample.com'
          fill_in 'パスワード', with: 'password'
          click_button 'ログインする'
  
          visit new_admin_webbook_page_path(webbook_a.id)
          fill_in 'Title', with: 'テストタイトル'
          fill_in 'Content', with: '最高のコンテンツ'
          click_button '送信'
        end

        it 'Pageのレコードが追加される' do
          # RFC: レコードが一つ追加されると書いたが、これでいいか？
          expect(Webbook.find_by(id: webbook_a).pages.count).to eq 2
        end
      end

      # context 'pageが追加されない' do
      # end
    end
  end

  describe 'page#edit' do
    describe '管理者の場合page#editが表示される' do
      context '管理者の場合' do
        it 'page編集が表示される' do
        end
      end

      context 'ユーザーの場合' do
        it 'トップページへリダイレクトされる' do
        end
      end
    end
    
    describe 'pageを編集することができる' do
      context 'pageが変更される' do
        it 'pageのレコードが変更される' do
        end
      end

      context 'pageが変更されない' do
      end
    end
  end

  describe 'page#destroy' do
    describe 'pageを削除することができる' do
      context 'pageが削除される' do
        it 'pageのレコードが1つ減っている' do
        end
      end

      context 'pageが削除されない' do
      end
    end
  end
end
