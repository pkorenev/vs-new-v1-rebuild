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
    @section = :contact
    @selected_tab = 'contact'
    render template: 'contact/show'

  end

  # order form

  def order_show
    @section = :order
    @selected_tab = 'order'
    @order = Forms::Order.new
    render template: 'contact/show'
  end

  def order_create
    @section = :order
    f = Forms::Order.new
    f.name = params['name']
    f.phone = params['phone']
    f.organization_name = params['organization_name']
    f.email = params['email']
    f.money = params['money']
    f.text = params['message']


    OrderMailer.new_letter(f).deliver

    render inline: f.inspect

    #render template: 'contact/show'
  end

  def order_validate_form

  end

  # join us form

  def join_us_show
    @section = :join_us
    @selected_tab = 'join_us'
    @join_us = Forms::JoinUs.new
    render template: 'contact/show'
  end

  def join_us_create
    @section = :join_us
    @join_us_form = params['']
    render template: 'contact/show'
  end

  def join_us_validate_form

  end
end