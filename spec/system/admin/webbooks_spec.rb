require 'rails_helper'

RSpec.describe "Admin#Webbook", type: :system do
  describe 'Webbook#new' do
    describe '管理者の場合Webbook#newが表示される' do
      context '管理者の場合' do
        before do
          FactoryBot.create(:admin_user)
          visit login_path
          fill_in 'メールアドレス', with: 'admin@sample.com'
          fill_in 'パスワード', with: 'password'
          click_button 'ログインする'
  
          visit new_admin_webbook_path
        end
        it 'webbook作成ページが表示される' do
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
  
          visit new_admin_webbook_path
        end
        it 'トップページへリダイレクトされる' do
          expect(page).to have_current_path root_path
        end
      end
    end

    describe 'Webbookを作成することができる' do
      context 'Webbookが追加される' do
        before do
          FactoryBot.create(:admin_user)
          visit login_path
          fill_in 'メールアドレス', with: 'admin@sample.com'
          fill_in 'パスワード', with: 'password'
          click_button 'ログインする'
  
          visit new_admin_webbook_path
          fill_in 'タイトル', with: 'hogehoge'
          click_button '送信'
        end

        it 'Webbookのレコードが追加される' do
          # RFC: レコードが一つ追加されると書いたが、これでいいか？
          expect(Webbook.count).to eq 1
        end
        it '管理者用Top Pageが表示される' do
          expect(page).to have_current_path admin_webbook_path(Webbook.first.id)
        end
      end
    end
  end

  describe 'Webbook#edit' do
    let!(:webbook_a) { FactoryBot.create(:webbook) }

    describe '管理者の場合Webbook#editが表示される' do
      context '管理者の場合' do
        before do
          FactoryBot.create(:admin_user)
          visit login_path
          fill_in 'メールアドレス', with: 'admin@sample.com'
          fill_in 'パスワード', with: 'password'
          click_button 'ログインする'
  
          visit edit_admin_webbook_path(webbook_a.id)
        end
        it 'webbook編集ページが表示される' do
          expect(page).to have_current_path edit_admin_webbook_path(webbook_a.id)
        end
      end

      context 'ユーザーの場合' do
        before do
          FactoryBot.create(:user)
          visit login_path
          fill_in 'メールアドレス', with: 'user_1@sample.com'
          fill_in 'パスワード', with: 'password'
          click_button 'ログインする'
  
          visit edit_admin_webbook_path(webbook_a.id)
        end
        it 'トップページへリダイレクトされる' do
          expect(page).to have_current_path root_path
        end
      end
    end

    describe 'Webbookを編集することができる' do
      context 'Webbookが変更される' do
        before do
          FactoryBot.create(:admin_user)
          visit login_path
          fill_in 'メールアドレス', with: 'admin@sample.com'
          fill_in 'パスワード', with: 'password'
          click_button 'ログインする'
  
          visit edit_admin_webbook_path(webbook_a.id)
          fill_in 'タイトル', with: 'fugafuga'
          click_button '送信'
        end

        it '管理者用Top Pageが表示される' do
          expect(page).to have_current_path admin_root_path
        end
      end

      context 'Webbookが変更されない' do
      end
    end
  end

  describe 'Webbook#destroy' do
    describe 'Webbookを削除することができる' do
      let!(:webbook_a) { FactoryBot.create(:webbook) }

      before do
        FactoryBot.create(:admin_user)
        visit login_path
        fill_in 'メールアドレス', with: 'admin@sample.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'

        visit admin_webbook_path(webbook_a.id)

        click_link '削除'
      end
      context 'Webbookが削除される' do
        it '管理者トップ画面へ遷移する' do
          expect(page.driver.browser.switch_to.alert.text).to eq "「#{webbook_a.title}」を削除します。よろしいですか？"
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_current_path admin_root_path
        end

        it 'Webbookのレコードが1つ減っている' do
        end
      end
    end
  end
end
