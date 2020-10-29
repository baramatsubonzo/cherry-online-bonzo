require 'rails_helper'

RSpec.describe "Admin#Webbook", type: :system do
  describe 'Webbook#new' do
    describe '管理者の場合Webbook#newが表示される' do
      context '管理者の場合' do
        it 'webbook作成ページが表示される' do
        end
      end

      context 'ユーザーの場合' do
        it 'トップページへリダイレクトされる' do
        end
      end
    end

    describe 'Webbookを作成することができる' do
      context 'Webbookが追加される' do
        it 'Webbookのレコードが追加される' do
        end
      end

      context 'Webbookが追加されない' do
      end
    end
  end

  describe 'Webbook#edit' do
    describe '管理者の場合Webbook#editが表示される' do
      context '管理者の場合' do
        it 'webbook編集が表示される' do
        end
      end

      context 'ユーザーの場合' do
        it 'トップページへリダイレクトされる' do
        end
      end
    end

    describe 'Webbookを編集することができる' do
      context 'Webbookが変更される' do
        it 'Webbookのレコードが変更される' do
        end
      end

      context 'Webbookが変更されない' do
      end
    end
  end

  describe 'Webbook#destroy' do
    describe 'Webbookを削除することができる' do
      context 'Webbookが削除される' do
        it 'Webbookのレコードが1つ減っている' do
        end
      end

      context 'Webbookが削除されない' do
      end
    end
  end
end
