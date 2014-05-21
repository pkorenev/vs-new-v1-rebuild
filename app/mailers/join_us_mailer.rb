# -*- encoding : utf-8 -*-
class JoinUsMailer < ActionMailer::Base
  default from: "support@voroninstudio.eu"
  default to: []

  def new_letter(order)
    @join_us_form = order
    to = []
    to = FormConfig.find(3).form_receiver_list

    mail(:to =>  to , :subject => "New letter form your website!", template_path: 'mailers', template_name: 'join_us')
  end
end
