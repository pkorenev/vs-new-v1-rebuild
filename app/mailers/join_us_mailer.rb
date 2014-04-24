# -*- encoding : utf-8 -*-
class JoinUsMailer < ActionMailer::Base
  default from: "support@voroninstudio.eu"
  default to: ["oprusko@meta.ua", "ostaphorak@gmail.com"]

  def order_form(order)
    @order = order
    mail(:to => "#{order.email}", :subject => "New letter form your website!")
  end
end
