require 'payjp'

class MyPayjp

  Payjp::api_key = ENV['PAYJP_PRIVATE_KEY']

  #
  # カードトークンを生成する
  #
  def self.create_token(number, cvc, exp_month, exp_year)
    token = Payjp::Token.create(
      card: {
        number:    number,
        cvc:       cvc,
        exp_year:  exp_year,
        exp_month: exp_month,
      }
    )
    return token.id
  end

  #
  # カードトークンを用いて支払いを作成する
  #
  def self.create_charge_by_token(token, amount)
    Payjp::Charge.create(
      amount:   amount,
      card:     token,
      currency: 'jpy'
    )
  end

  #
  # 顧客を登録する
  #
  def self.create_customer(number, cvc, exp_month, exp_year)
    token = self.create_token(number, cvc, exp_month, exp_year)
    Payjp::Customer.create(card: token)
  end

  #
  # 顧客を用いて支払いを作成する
  #
  def self.create_charge_by_customer(customer, amount)
    Payjp::Charge.create(
      amount:   amount,
      customer: customer,
      currency: 'jpy'
    )
  end

  #
  # プランを作成する
  #
  def self.create_plan(amount, interval = 'month')
    Payjp::Plan.create(
      amount:   amount,
      interval: interval,
      currency: 'jpy'
    )
  end

  #
  # 定額課金を作成する
  #
  def self.create_subscription(customer, plan)
    Payjp::Subscription.create(
      customer: customer,
      plan:     plan,
    )
  end

end
