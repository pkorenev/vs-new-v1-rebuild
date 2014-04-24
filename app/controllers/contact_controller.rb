class ContactController < ApplicationController

  layout :resolve_layout

  def resolve_layout
    #if params['iframe']
      'contact_layout'
    #else
    #  'application'
    #end
  end


  def contact_show
    @selected_tab = 'contact'
    render template: 'contact/show'

  end

  # order form

  def order_show
    @selected_tab = 'order'
    @order = Forms::Order.new
    render template: 'contact/show'
  end

  def order_create
    f = Forms::Order.new
    f.name = params['name']
    f.phone = params['phone']
    f.organization_name = params['organization_name']
    f.email = params['email']
    f.money = params['money']
    f.text = params['text']

    OrderMailer.new_letter(f).deliver


    render template: 'contact/show'
  end

  def order_validate_form

  end

  # join us form

  def join_us_show
    @selected_tab = 'join_us'
    @order = Forms::Order.new
    render template: 'contact/show'
  end

  def join_us_create
    @join_us_form = params['']
    render template: 'contact/show'
  end

  def join_us_validate_form

  end
end