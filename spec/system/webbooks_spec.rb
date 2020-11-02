require 'rails_helper'

RSpec.describe "Webbook", type: :system do
  describe 'ユーザーはトップページでWebブックの一覧を閲覧できる' do
    context 'ユーザーがログインしている時' do
      before do
        FactoryBot.create(:user)
        visit login_path
        fill_in 'メールアドレス', with: 'user_1@sample.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'
      end
      it 'Webbook一覧が見れる' do
        expect(page).to have_current_path root_path
      end
    end

    context 'ユーザーがログインしていない時' do
      before do
        visit root_path
      end
      it 'ログイン画面へリダイレクトされる' do
        expect(page).to have_current_path login_path
      end
    end
  end

  describe 'ユーザーは一覧からWebブックを選択し、その本の基本情報やページ数、目次などを確認できる' do
    let(:webbook) { FactoryBot.create(:webbook) }

    context 'ユーザーがログインしている時' do
      before do
        FactoryBot.create(:user)
        visit login_path
        fill_in 'メールアドレス', with: 'user_1@sample.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'
        visit webbook_path(webbook)
      end

      it '詳細ページが表示される' do
        expect(page).to have_content("最初の本")
      end
    end

    context 'ユーザーがログインしていない時' do
      before do
        visit webbook_path(webbook)
      end
      it 'ログイン画面へリダイレクトされる' do
        expect(page).to have_current_path login_path
      end
    end
  end

  describe 'ユーザーはマイページで購入したWebブックの一覧を閲覧できる' do
    context 'ユーザーAがログインしている時' do
      let(:user_a) { FactoryBot.create(:user) }
      let(:webbook_a) { FactoryBot.create(:webbook) }
      let(:purchase_history) { FactoryBot.create(:purchase_history, user: user_a) }
      let!(:purchase_history_webbook) { FactoryBot.create(:purchase_history_webbook, purchase_history: purchase_history, webbook: webbook_a) }

      before do
        FactoryBot.create(:page, webbook_id: webbook_a.id)
        visit login_path
        fill_in 'メールアドレス', with: 'user_1@sample.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'

        visit mypage_path
      end

      it 'ユーザーAが購入したWebブックが表示される' do
        expect(page).to have_content("最初の本")
      end
    end

    context 'ユーザーBがログインしている時' do
      let(:user_2) { FactoryBot.create(:user, email: 'user_2@sample.com') }
      let(:webbook_2) { FactoryBot.create(:webbook, title: '2番目の本') }
      let(:purchase_history) { FactoryBot.create(:purchase_history, user: user_2) }
      let!(:purchase_history_webbook) { FactoryBot.create(:purchase_history_webbook, purchase_history: purchase_history, webbook: webbook_2) }

      before do
        FactoryBot.create(:page, webbook_id: webbook_2.id)
        visit login_path
        fill_in 'メールアドレス', with: 'user_2@sample.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'

        visit mypage_path
      end
      it 'ユーザーAの購入したWebブックが表示されない' do
        expect(page).not_to have_content("最初の本")
      end
    end
  end

  describe '公開フラグがfalseだとエンドユーザーにWebブックが公開されない' do
    let!(:user_a) { FactoryBot.create(:user) }
    let!(:webbook_a) { FactoryBot.create(:webbook, title: '公開されてない本', release: false) }
    let!(:webbook_b) { FactoryBot.create(:webbook, title: '公開本', release: true) }

    before do
      visit login_path
      fill_in 'メールアドレス', with: 'user_1@sample.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログインする'

      visit root_path
    end

    context '公開フラグがfalseの場合' do
      it '一覧ページに表示されない' do
        expect(page).not_to have_content('公開されていない本')
      end
    end

    context '公開フラグがtrueの場合' do
      it '一覧ページに表示される' do
        expect(page).to have_content('公開本')
      end
    end
  end
end
