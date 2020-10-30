require 'rails_helper'

RSpec.describe "Page", type: :system do
  describe 'ユーザーは購入しているWebブック#Pageを確認できる' do
    context '購入履歴がある場合' do
      let(:user_a) { FactoryBot.create(:user) }
      let(:webbook_a) { FactoryBot.create(:webbook) }
      let(:page_a) { FactoryBot.create(:page, webbook_id: webbook_a.id) }
      let(:purchase_history) { FactoryBot.create(:purchase_history, user: user_a) }
      let!(:purchase_history_webbook) { FactoryBot.create(:purchase_history_webbook, purchase_history: purchase_history, webbook: webbook_a) }

      before do
        visit login_path
        fill_in 'メールアドレス', with: 'user_1@sample.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'

        visit webbook_page_path(webbook_a.id, page_a)
      end

      it 'ユーザーAが購入したWebブックが表示される' do
        expect(page).to have_content("最初の頁")
      end
    end

    context '購入履歴がない場合' do
      let(:user_a) { FactoryBot.create(:user) }
      let(:webbook_a) { FactoryBot.create(:webbook) }
      let(:page_a) { FactoryBot.create(:page, webbook_id: webbook_a.id) }
      let(:purchase_history) { FactoryBot.create(:purchase_history, user: user_a) }
      let!(:purchase_history_webbook) { FactoryBot.create(:purchase_history_webbook, purchase_history: purchase_history, webbook: webbook_a) }

      let(:user_b) { FactoryBot.create(:user, name: 'ほげほげ',email: "hogehoge@sample.com") }
      let(:webbook_b) { FactoryBot.create(:webbook, title: "hogehoge") }
      let(:purchase_history) { FactoryBot.create(:purchase_history, user: user_b) }
      let!(:purchase_history_webbook) { FactoryBot.create(:purchase_history_webbook, purchase_history: purchase_history, webbook: webbook_b) }

      before do
        visit login_path
        fill_in 'メールアドレス', with: user_b.email
        fill_in 'パスワード', with: user_b.password
        click_button 'ログインする'

        visit webbook_page_path(webbook_a.id, page_a)
      end

      it 'トップ画面に飛ばされる' do
        expect(page).to have_current_path root_path
      end
    end
  end
end
