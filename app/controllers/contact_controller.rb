class ContactController < ApplicationController

  layout :resolve_layout

  before_filter :create_join_us_form

  caches_page :order_show
  caches_page :join_us_show
  caches_page :contact_show

  def create_join_us_form
    @join_us = Forms::JoinUs.new
  end

  def resolve_layout
    if params['modal'] == 'true'
      'contact_layout'
    else
      'application'
    end
  end


  def contact_show
    @section = :contact
    @selected_tab = 'contact'

    @page_data = Pages::ContactPage.first
    @static_page_data = @page_data.static_page_data

    render template: 'contact/show'

  end

  # order form

  def order_show
    @section = :order
    @selected_tab = 'order'
    @order = Forms::Order.new

    @page_data = Pages::OrderPage.first
    @static_page_data = @page_data.static_page_data

    render template: 'contact/show'
  end

  def order_create
    @section = :order
    f = Forms::Order.new
    f.name = params['name']
    f.phone = params['phone']
    f.organization_name = params['organization']
    f.email = params['email']
    f.money = params['price-range']
    f.text = params['message']
    f.save

    @hostname = request.host

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


    @page_data = Pages::JoinUsPage.first
    @static_page_data = @page_data.static_page_data

    render template: 'contact/show'
  end

  def join_us_create
    @section = :join_us
    #@join_us_form = params['']

    f = Forms::JoinUs.new
    f.name = params['name']
    f.phone = params['phone']
    #f.organization_name = params['organization_name']
    f.email = params['email']
    f.portfolio = (params['forms_join_us'])? params['forms_join_us']['portfolio'] : nil
    f.role = params['vacancy']
    f.text = params['message']

    f.save
    #render inline: params['forms_join_us']['portfolio'].inspect

    #@hostname = request.inspect
    flash[:submitted] = "Your message was successfully submitted"

    JoinUsMailer.new_letter(f).deliver

    @join_us = Forms::JoinUs.new
    render template: 'contact/show'
  end

  def join_us_validate_form

  end
end
