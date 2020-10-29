require 'rails_helper'

RSpec.describe "Webbook", type: :system do
  describe 'ユーザーはトップページでWebブックの一覧を閲覧できる' do
    context 'ユーザーがログインしている時' do
      it 'トップページへリダイレクトされる' do
      end
    end

    cotext 'ユーザーがログインしていない時' do
      it 'ログイン画面へリダイレクトされる' do
      end
    end
  end

  describe 'ユーザーは一覧からWebブックを選択し、その本の基本情報やページ数、目次などを確認できる' do
    context 'ユーザーがログインしている時' do
      it 'トップページへリダイレクトされる' do
      end
    end

    cotext 'ユーザーがログインしていない時' do
      it 'ログイン画面へリダイレクトされる' do
      end
    end
  end

  describe 'ユーザーはマイページで購入したWebブックの一覧を閲覧できる' do
    context 'ユーザーAがログインしている時' do
      it 'ユーザーAが購入したWebブックが表示される' do
      end
    end

    cotext 'ユーザーBがログインしている時' do
      it 'ユーザーAの購入したWebブックが表示されない' do
      end
    end
  end

  describe 'ユーザーはマイページで購入したWebブックのページを閲覧できる' do
    context 'ユーザーAがログインしている時' do
      it 'ユーザーAが購入したWebブックのページが表示される' do
      end
    end

    cotext 'ユーザーBがログインしている時' do
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
