module Resource
	@dependent_resources = []
	@affected_resources = []

	def generate_slug
		self.slug = self.name.parameterize if self.slug.blank?
		self.translations_by_locale.each do |locale, t|
			t.slug = t.name.parameterize if t.slug.blank?
		end	
	end	

	def generate_static_page_data
	    if self.static_page_data.nil?
	      self.build_static_page_data
	    end  

	    s = self.static_page_data

	    if s.sitemap_element.nil?
	    	s.build_sitemap_element
	    end	

	    e = s.sitemap_element

	    s.translations_by_locale.each do |locale, t|
	    	t.head_title 
	    end  
  end 



  def render_dependent_resources

  end	

  def affects_on *args
  	self
  end	


end	

