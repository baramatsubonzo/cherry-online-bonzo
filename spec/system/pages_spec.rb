require 'rails_helper'

RSpec.describe "Page", type: :system do
  let(:user_a) { FactoryBot.create(:user) }
  let(:user_b) { FactoryBot.create(:user, name: 'ほげほげ',email: "hogehoge@sample.com") }

  let(:webbook_a) { FactoryBot.create(:webbook) }
  let(:webbook_b) { FactoryBot.create(:webbook, title: "hogehoge") }

  let(:page_a) { FactoryBot.create(:page, webbook_id: webbook_a.id) }

  let(:purchase_history) { FactoryBot.create(:purchase_history, user: login_user) }
  let!(:purchase_history_webbook) { FactoryBot.create(:purchase_history_webbook, purchase_history: purchase_history, webbook: purchased_webbook) }

  before do
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  describe 'ユーザーは購入しているWebブック#Pageを確認できる' do

    context '購入履歴がある場合' do
      let(:login_user) { user_a }
      let(:purchased_webbook) { webbook_a }
      
      before do
        visit webbook_page_path(webbook_a.id, page_a)
      end

      it 'ユーザーAが購入したWebブックが表示される' do
        expect(page).to have_content("最初の頁")
      end
    end

    context '購入履歴がない場合' do
      let(:login_user) { user_b }
      let(:purchased_webbook) { webbook_b }

      before do
        visit webbook_page_path(webbook_a.id, page_a)
      end

      it 'トップ画面に飛ばされる' do
        expect(page).to have_current_path root_path
      end
    end
  end
end
