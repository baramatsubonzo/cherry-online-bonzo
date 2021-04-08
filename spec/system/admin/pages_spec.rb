require 'rails_helper'

RSpec.describe 'Admin#Page', type: :system do
  let(:admin_user_1) { FactoryBot.create(:admin_user) }
  let(:user_1) { FactoryBot.create(:user) }

  before do
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  describe 'page#new' do
    describe '管理者の場合page#newが表示される' do
      let(:webbook_a) { FactoryBot.create(:webbook) }

      context '管理者の場合' do
        let(:login_user) { admin_user_1 }

        before do
          visit new_admin_webbook_path
        end

        it 'page作成ページが表示される' do
          expect(page).to have_current_path new_admin_webbook_path
        end
      end

      context 'ユーザーの場合' do
        let(:login_user) { user_1 }

        before do
          visit new_admin_webbook_page_path(webbook_a.id)
        end

        it 'トップページへリダイレクトされる' do
          expect(page).to have_current_path root_path
        end
      end
    end

    describe 'pageを作成することができる' do
      let(:webbook_a) {FactoryBot.create(:webbook)}

      context 'pageが追加される' do
        let(:login_user) { admin_user_1 }

        before do
          FactoryBot.create(:page, webbook_id: webbook_a.id)

          visit new_admin_webbook_page_path(webbook_a.id)
          fill_in 'タイトル', with: 'テストタイトル'
          fill_in 'コンテンツ', with: '最高のコンテンツ'
          click_button '送信'
        end

        it 'Pageのレコードが追加される' do
          expect(Webbook.find_by(id: webbook_a).pages.count).to eq 2
        end
      end
    end
  end

  describe 'page#edit' do
    describe '管理者の場合page#editが表示される' do
      let(:webbook_a) {FactoryBot.create(:webbook)}
      let(:login_user) { admin_user_1 }

      context '管理者の場合' do
        before do
          visit edit_admin_webbook_path(webbook_a.id)
        end

        it 'page編集が表示される' do
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

    describe 'pageを編集することができる' do
      context 'pageが変更される' do
        let(:login_user) { admin_user_1 }
        let!(:page_a) { FactoryBot.create(:page, title: 'hoge', content: 'fuga') }

        context 'pageが追加される' do
          before do
            visit edit_admin_webbook_page_path(page_a.webbook_id, page_a.id)
            fill_in 'タイトル', with: 'テストタイトル'
            fill_in 'コンテンツ', with: '最高のコンテンツ'
            click_button '送信'
          end

          it 'pageのレコードが変更される' do
            expect(page).to have_content 'テストタイトル'
          end
        end
      end
    end
  end

  describe 'page#destroy' do
    describe 'pageを削除することができる' do
      context 'pageが削除される' do
        let(:login_user) { admin_user_1 }
        let!(:page_a) { FactoryBot.create(:page, title: 'hoge', content: 'fuga') }

        before do
          visit admin_webbook_page_path(page_a.webbook_id, page_a.id)

          click_link '削除'
          expect(page.driver.browser.switch_to.alert.text).to eq "「#{page_a.title}」を削除します。よろしいですか？"
          page.driver.browser.switch_to.alert.accept
        end

        it 'pageのレコードが1つ減っている' do
          expect(page).to have_content('削除しました')
        end
      end
    end
  end
end
