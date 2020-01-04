require 'rails_helper'

describe Number do

  describe '必須項目のテスト' do
    it 'tellが空白の場合非通過' do
      number = build(:number, tell: "")
      number.valid?
      expect(number.errors[:tell]).to include("can't be blank")
    end
    it "正常値" do
      number = build(:number)
      expect(number).to be_valid
    end
  end

 
  describe '正規表現のテスト' do
    it 'tellが10桁の場合非通過' do
      number = build(:number, tell: "1234567890")
      number.valid?
      expect(number).to be_invalid
    end
    it 'tellが12桁の場合非通過' do
      number = build(:number, tell: "123456789012")
      number.valid?
      expect(number).to be_invalid
    end
    it 'tellが11桁の数字の場合通過' do
      number = build(:number, tell: "12345678901")
      number.valid?
      expect(number).to be_valid
    end
  end
end