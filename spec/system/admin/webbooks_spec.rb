require 'rails_helper'

RSpec.describe 'Admin#Webbook', type: :system do
  let(:admin_user_1) { FactoryBot.create(:admin_user) }
  let(:user_1) { FactoryBot.create(:user) }

  before do
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  describe 'Webbook#new' do
    describe '管理者の場合Webbook#newが表示される' do
      context '管理者の場合' do
        let(:login_user) { admin_user_1 }

        before do
          visit new_admin_webbook_path
        end

        it 'webbook作成ページが表示される' do
          expect(page).to have_current_path new_admin_webbook_path
        end
      end

      context 'ユーザーの場合' do
        let(:login_user) { user_1 }

        before do
          visit new_admin_webbook_path
        end

        it 'トップページへリダイレクトされる' do
          expect(page).to have_current_path root_path
        end
      end
    end

    describe 'Webbookを作成することができる' do
      context 'Webbookが追加される' do
        let(:login_user) { admin_user_1 }

        before do
          visit new_admin_webbook_path
          fill_in 'タイトル', with: 'hogehoge'
          click_button '送信'
        end

        it 'Webbookのレコードが追加される' do
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
        let(:login_user) { admin_user_1 }

        before do
          visit edit_admin_webbook_path(webbook_a.id)
        end

        it 'webbook編集ページが表示される' do
          expect(page).to have_current_path edit_admin_webbook_path(webbook_a.id)
        end
      end

      context 'ユーザーの場合' do
        let(:login_user) { user_1 }

        before do
          visit edit_admin_webbook_path(webbook_a.id)
        end

        it 'トップページへリダイレクトされる' do
          expect(page).to have_current_path root_path
        end
      end
    end

    describe 'Webbookを編集することができる' do
      context 'Webbookが変更される' do
        let(:login_user) { admin_user_1 }

        before do
          visit edit_admin_webbook_path(webbook_a.id)
          fill_in 'タイトル', with: 'fugafuga'
          click_button '送信'
        end

        it '管理者用Top Pageが表示される' do
          expect(page).to have_current_path admin_root_path
        end
      end
    end
  end

  describe 'Webbook#destroy' do
    describe 'Webbookを削除することができる' do
      let!(:webbook_a) { FactoryBot.create(:webbook) }
      let(:login_user) { admin_user_1 }

      before do
        visit admin_webbook_path(webbook_a.id)

        click_link '削除'
      end

      context 'Webbookが削除される' do
        it '管理者トップ画面へ遷移する' do
          expect(page.driver.browser.switch_to.alert.text).to eq "「#{webbook_a.title}」を削除します。よろしいですか？"
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_current_path admin_root_path
        end
      end
    end
  end
end
