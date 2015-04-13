module RailsAdminMethods
	def rails_admin_model_to_param
		self.class.to_s.split('::').collect(&:underscore).join('~')
		#"test"
	end	
end