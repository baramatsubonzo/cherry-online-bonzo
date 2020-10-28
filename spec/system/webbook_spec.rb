require 'rails_helper'

RSpec.describe "Webbook", type: :system do
  describe '公開フラグがfalseだとエンドユーザーにWebブックが公開されない' do
    context '公開フラグがtrueの場合' do
    end
    context '公開フラグがfalseの場合' do
    end
  end

  describe '発売日がまだ来ていないWebブックは購入できない' do
    context '発売日が今日より後の場合(購入できない)' do
    end

    context '発売日が今日より前の場合(購入できる)' do
    end
  end

  describe 'ユーザーは購入しているwebbookのpageを閲覧することができる' do
    context 'ユーザーの購入履歴にwebbookが存在する' do
    end
    context 'ユーザーの購入履歴にwebbookが存在しない' do
    end
  end
end
