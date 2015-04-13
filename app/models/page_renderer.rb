require 'render_anywhere'
class PageRenderer
	include RenderAnywhere
	def home_page
		controller = PageController
		controller_instance = controller.new
		data = controller_instance.index_data
		#controller_instance.
		str = render template: "page/index"
		#file_uri = Rails.root.join('public/uk/index.html')
		#File.write(file_uri, str)
		str
	end	

	def rendering_controller
		#@rendering_controller ||= OfflineTemplate.new
		@rendering_controller ||= AppRenderController.new
	end	
end	