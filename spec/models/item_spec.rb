require 'rails_helper'

describe Item do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品がうまくいくとき' do
      it "imageとname、info、category＿id、sales＿status＿id、 shipping_fee_status_id、 prefecture_id、 scheduled_delivery_id、 priceが存在すれば登録できる" do
        expect(@item).to be_valid
      end
    end

    context '商品出品がうまくいかないとき' do
      it "imageが空なら登録できない" do
        @item.image = nil
        @item.valid?
        # binding.pry
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it "nameが空なら登録できない" do
        @item.name = ""
        @item.valid?
        # binding.pry
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "infoが空なら登録できない" do
        @item.info = nil
        @item.valid?
        # binding.pry
        expect(@item.errors.full_messages).to include("Info can't be blank")
      end
      it "priceが空なら登録できない" do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it "金額が全角数字" do
        @item.price = '５００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end
      it "金額の範囲が299円以下なら登録できない" do
        @item.price = "299"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price out of setting range")
      end
      it "金額の範囲が10_000_000円以上なら登録できない" do
        @item.price = "10_000_000"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price out of setting range")
      end
      it 'category_id:0以外' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Category Select")
      end
      it 'sales_status_id:0以外' do
        @item.sales_status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Sales status Select")
      end
      it 'shipping_fee_status_id:0以外' do
        @item.shipping_fee_status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee status Select")
      end
      it 'prefecture_id:0以外' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture Select")
      end
      it 'scheduled_delivery_id:0以外' do
        @item.scheduled_delivery_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Scheduled delivery Select")
      end
    end
  end
end