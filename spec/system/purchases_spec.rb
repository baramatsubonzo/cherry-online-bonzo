require 'rails_helper'

RSpec.describe "Webbookを購入する", type: :system do
  describe 'ユーザーはwebbookを購入できる' do
    context '購入履歴にWebbookがない場合' do
      it 'purchase_history_webbooksにレコードが増える' do
      end

      it '購入完了のメールが通知される' do
      end
    end
    context '購入履歴にWebbookがある場合' do
      it 'purchase_history_webbooksにレコードが変わらない' do
      end
    end
  end

  describe '発売日がまだ来ていないWebブックは購入できない' do
    context '発売日が今日より後の場合(購入できない)' do
    end

    context '発売日が今日より前の場合(購入できる)' do
    end
  end
end
