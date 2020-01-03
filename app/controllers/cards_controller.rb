class CardsController < ApplicationController
  require 'payjp'

  # 後ほど登録したクレジットの表示画面を作成します。

  # クレジットカード情報入力画面
  def new
    if @card
      redirect_to card_path unless @card
    else
    end
  end

  def create
    binding.pry
    Payjp.api_key = "sk_test_f67be4ad1051de6822903d38"
    if params['payjp-token'].blank?
    else
      customer = Payjp::Customer.create( # ここで先ほど生成したトークンを顧客情報と紐付け、PAY.JP管理サイトに送信
        email: current_user.email,
        card: params['payjp-token'],
        metadata: {user_id: current_user.id} # 記述しなくても大丈夫です
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      binding.pry
      if @card.save
        redirect_to root_path
      else
      end
    end
  end
end
