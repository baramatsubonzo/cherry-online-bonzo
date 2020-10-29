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
        expect(page).to have_content("ユーザー用Top Page")
      end
    end

    context 'ユーザーがログインしていない時' do
      before do
        visit root_path
      end
      it 'ログイン画面へリダイレクトされる' do
        expect(page).to have_content("ユーザーログイン")
      end
    end
  end

  describe 'ユーザーは一覧からWebブックを選択し、その本の基本情報やページ数、目次などを確認できる' do
    context 'ユーザーがログインしている時' do
      let(:webbook) { FactoryBot.create(:webbook) }
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
      it 'ログイン画面へリダイレクトされる' do
      end
    end
  end

  describe 'ユーザーはマイページで購入したWebブックの一覧を閲覧できる' do
    context 'ユーザーAがログインしている時' do
      it 'ユーザーAが購入したWebブックが表示される' do
      end
    end

    context 'ユーザーBがログインしている時' do
      it 'ユーザーAの購入したWebブックが表示されない' do
      end
    end
  end

  describe 'ユーザーはマイページで購入したWebブックのページを閲覧できる' do
    context 'ユーザーAがログインしている時' do
      it 'ユーザーAが購入したWebブックのページが表示される' do
      end
    end

    context 'ユーザーBがログインしている時' do
      it 'ユーザーAの購入したWebブックのページが表示されない' do
      end
    end
  end

  describe '公開フラグがfalseだとエンドユーザーにWebブックが公開されない' do
    context '公開フラグがtrueの場合' do
    end
    context '公開フラグがfalseの場合' do
    end
  end
end
