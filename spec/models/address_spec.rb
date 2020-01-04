require 'rails_helper'

describe Address do

  describe '必須項目のテスト' do 
    it 'last_nameが空白' do
      address = build(:address, last_name: "")
      address.valid?
      expect(address.errors[:last_name]).to include("can't be blank")
    end
    it 'first_nameが空白' do
      address = build(:address, first_name: "")
      address.valid?
      expect(address.errors[:first_name]).to include("can't be blank")
    end
    it 'last_name_kanaが空白' do
      address = build(:address, last_name_kana: "")
      address.valid?
      expect(address.errors[:last_name_kana]).to include("can't be blank")
    end
    it 'first_name_kanaが空白' do
      address = build(:address, first_name_kana: "")
      address.valid?
      expect(address.errors[:first_name_kana]).to include("can't be blank")
    end
    it 'postcodeが空白' do
      address = build(:address, postcode: "")
      address.valid?
      expect(address.errors[:postcode]).to include("can't be blank")
    end
    it 'cityが空白' do
      address = build(:address, city: "")
      address.valid?
      expect(address.errors[:city]).to include("can't be blank")
    end
    it 'blockが空白' do
      address = build(:address, block: "")
      address.valid?
      expect(address.errors[:block]).to include("can't be blank")
    end
    it 'buildingが空白' do
      address = build(:address, building: "")
      expect(address).to be_valid
    end
    it "正常値" do
      address = build(:address)
      expect(address).to be_valid
    end
  end

  describe '正規表現テスト' do
    it 'last_nameが[漢字、ひらがな、カタカナ]以外を含む場合非通過' do
      address = build(:address, last_name: 'testtes')
      address.valid?
      expect(address).to be_invalid
    end

    it 'first_nameが[漢字、ひらがな、カタカナ]以外を含む場合非通過' do
      address = build(:address, first_name: 'testtes')
      address.valid?
      expect(address).to be_invalid
    end

    it 'last_name_kanaが[漢字]を含む場合非通過' do
      address = build(:address, last_name_kana: '正規表現')
      address.valid?
      expect(address).to be_invalid
    end

    it 'first_name_kanaが[漢字]を含む場合非通過' do
      address = build(:address, first_name_kana: '正規表現')
      address.valid?
      expect(address).to be_invalid
    end

    it 'last_name_kanaが[ひらがな]を含む場合非通過' do
      address = build(:address, last_name_kana: 'せいきひょうげん')
      address.valid?
      expect(address).to be_invalid
    end

    it 'first_name_kanaが[ひらがな]を含む場合非通過' do
      address = build(:address, first_name_kana: 'せいきひょうげん')
      address.valid?
      expect(address).to be_invalid
    end

    it 'last_name_kanaが[英数字]を含む場合非通過' do
      address = build(:address, last_name_kana: 'test0')
      address.valid?
      expect(address).to be_invalid
    end

    it 'first_name_kanaが[英数字]を含む場合非通過' do
      address = build(:address, first_name_kana: 'test0')
      address.valid?
      expect(address).to be_invalid
    end

    it 'tellが10桁の場合非通過' do
      address = build(:address, tell: "1234567890")
      address.valid?
      expect(address).to be_invalid
    end

    it 'tellが12桁の場合非通過' do
      address = build(:address, tell: "123456789012")
      address.valid?
      expect(address).to be_invalid
    end

    it 'tellが11桁の数字の場合通過' do
      address = build(:address, tell: "12345678901")
      address.valid?
      expect(address).to be_valid
    end

    it 'postcodeが[●●●-●●●●]なら通過' do
      address = build(:address, postcode: "123-4567")
      address.valid?
      expect(address).to be_valid
    end

    it 'postcodeが[-なしなら]なら非通過' do
      address = build(:address, postcode: "1234567")
      address.valid?
      expect(address).to be_invalid
    end
  end

  describe '一意性テスト' do
    it 'tellが重複' do
      address = create(:address)
      another_address = build(:address)
      another_address.valid?
      expect(another_address.errors[:tell]).to include("has already been taken")
    end
  end

end