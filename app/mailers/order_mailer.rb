# -*- encoding : utf-8 -*-
class OrderMailer < ActionMailer::Base
  default from: "support@voroninstudio.eu"
  default to: []

  def new_letter(order)
    @order = order
    mail(:to => "#{order.email}", :subject => "New letter form your website!", template_path: 'mailers', template_name: 'order')
  end
end
