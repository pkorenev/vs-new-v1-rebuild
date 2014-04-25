# -*- encoding : utf-8 -*-
class OrderMailer < ActionMailer::Base
  default from: "support@voroninstudio.eu"
  default to: []

  def new_letter(order)
    @order = order

    mail(:to => "#{ [ 'support@voroninstudio.eu', 'p.korenev@voroninstudio.eu', 'pasha_kor@mail.ru' ] }", :subject => "New letter form your website!", template_path: 'mailers', template_name: 'order')
  end
end
