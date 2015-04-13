#require 'render_anywhere'

  	
class TestController < ApplicationController
  #include RenderAnywhere

  #caches_page :test2

  def media_queries
  end

  def test
  	

  	rendered_html = ""
  	output_html = "hello"

  	#renderer = ActionView::Renderer.new
  	#renderer.render inline: output_html
  	body = PageRenderer.new.home_page
  	render inline: body
  end	

  def test2
  	render layout: "application"
  end	

  def render_action controller, action 

  end
end
