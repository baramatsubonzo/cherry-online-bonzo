require 'rails_helper'

RSpec.describe "Admin#Page", type: :system do
  describe 'page#new' do
    describe '管理者の場合page#newが表示される' do
      context '管理者の場合' do
        it 'page作成ページが表示される' do
        end
      end

      context 'ユーザーの場合' do
        it 'トップページへリダイレクトされる' do
        end
      end
    end

    describe 'pageを作成することができる' do
      context 'pageが追加される' do
        it 'pageのレコードが追加される' do
        end
      end

      context 'pageが追加されない' do
      end
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
