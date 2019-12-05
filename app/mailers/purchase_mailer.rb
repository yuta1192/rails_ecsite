class PurchaseMailer < ApplicationMailer
  default from: 'ecadmin@example.com'

  def creation_email(cart_items)
    @cart_items = cart_items
    mail(
      subject: '商品購入完了メール',
      to: 'user@example.com',
      from: 'admin@example.com'
    )
  end
end
