require 'rails_helper'

RSpec.describe PayForm, type: :model do
  before do
    buyer = FactoryBot.create(:user)
    seller = FactoryBot.create(:user)
    item = FactoryBot.build(:item, user_id: seller.id)
    item.image = fixture_file_upload('/sample.png', 'image/png')
    item.save
    @pay_form = FactoryBot.build(:pay_form, user_id: buyer.id, item_id: item.id)
  end
  describe '商品購入' do
    context '内容に問題ない場合' do
      it '全て正常' do
      end
    end
    context "内容に問題がある場合" do
      it "tokenがない" do
      end
      it "郵便番号が空欄" do
      end
      it "郵便番号のフォーマットが正しくない" do
      end
      it "都道府県が空欄" do
      end
      it "都道府県の選択をしていない" do
      end
      it "市区町村GA空欄" do
      end
      it "番地が空欄" do
      end
      it "電話番号が空欄" do
      end
      it "電話番号が11桁以内" do
      end
      it "電話番号が数字のみか" do
      end
    end
  end
end