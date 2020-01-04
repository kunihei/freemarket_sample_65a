require 'rails_helper'

describe User do

  describe '#create ' do
    it "nickname id brank" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end
    it "email id brank" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
    it "password id brank" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
    it "last_name id brank" do
      user = build(:user, last_name: "")
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end
    it "first_name id brank" do
      user = build(:user, first_name: "")
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end
    it "last_name_kana id brank" do
      user = build(:user, last_name_kana: "")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("can't be blank")
    end
    it "first_name_kana id brank" do
      user = build(:user, first_name_kana: "")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("can't be blank")
    end

    it 'パスワードが7文字以上なら通過' do 
      user = build(:user, password: "1234567")
      user.valid?
      expect(user).to be_valid
    end

    it 'パスワードが6文字以下なら非通過' do
      user = build(:user, password: '123456')
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 7 characters)")
    end

    

    it "正常値" do
      user = build(:user)
      expect(user).to be_valid
    end

  end

  describe '正規表現テスト' do 
    it 'emailが〜＠~でない場合非通過' do
      user = build(:user, email: 'testtes')
      user.valid?
      expect(user).to be_invalid
    end

    it 'last_nameが[漢字、ひらがな、カタカナ]以外を含む場合非通過' do
      user = build(:user, last_name: 'testtes')
      user.valid?
      expect(user).to be_invalid
    end

    it 'first_nameが[漢字、ひらがな、カタカナ]以外を含む場合非通過' do
      user = build(:user, first_name: 'testtes')
      user.valid?
      expect(user).to be_invalid
    end

    it 'last_name_kanaが[漢字]を含む場合非通過' do
      user = build(:user, last_name_kana: '正規表現')
      user.valid?
      expect(user).to be_invalid
    end

    it 'first_name_kanaが[漢字]を含む場合非通過' do
      user = build(:user, first_name_kana: '正規表現')
      user.valid?
      expect(user).to be_invalid
    end

    it 'last_name_kanaが[ひらがな]を含む場合非通過' do
      user = build(:user, last_name_kana: 'せいきひょうげん')
      user.valid?
      expect(user).to be_invalid
    end

    it 'first_name_kanaが[ひらがな]を含む場合非通過' do
      user = build(:user, first_name_kana: 'せいきひょうげん')
      user.valid?
      expect(user).to be_invalid
    end

    it 'last_name_kanaが[英数字]を含む場合非通過' do
      user = build(:user, last_name_kana: 'test0')
      user.valid?
      expect(user).to be_invalid
    end

    it 'first_name_kanaが[英数字]を含む場合非通過' do
      user = build(:user, first_name_kana: 'test0')
      user.valid?
      expect(user).to be_invalid
    end
  end

  describe '一意性のバリデーション' do
    it '一意性テスト :email' do
      user = create(:user)
      another_user = build(:user)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end
  end
end