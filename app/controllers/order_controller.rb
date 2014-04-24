class OrderController < ApplicationController

  layout :resolve_layout

  def resolve_layout
    if params['ajax']
      'contact_layout'
    else
      'application'
    end
  end


  def contact_show
    @order = Order.new
    render template: 'contact/show'

  end

  # order form

  def order_show
    @order = Order.new
    render template: 'contact/show'
  end

  def order_create
    render template: 'contact/show'
  end

  def order_validate_form

  end

  # join us form

  def join_us_show
    @order = Order.new
    render template: 'contact/show'
  end

  def join_us_create
    render template: 'contact/show'
  end

  def join_us_validate_form

  end
end