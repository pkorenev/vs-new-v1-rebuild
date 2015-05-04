module Resource
  def self.included(klass)
    klass.extend Resource::ClassMethods
    klass.include ActiveRecordResourceExpiration
    klass.include PaperclipEnhancements::InstanceMethods
    klass.extend PaperclipEnhancements::ClassMethods
    klass.class_eval(&:my_included)
  end

  # def initialize
  #   #attr_accessible(*attribute_names)
  #   #attr_accessible(*attribute_names)
  # end

  module ClassMethods
    attr_accessor :_paperclip_field_names



    def my_included
      accessible_all_attributes

      before_validation do
        klass = self.class
        klass.paperclip_field_names.each do |paperclip_field_name|
          if self.send("delete_#{paperclip_field_name}") == '1'
            self.send(paperclip_field_name).clear
            self.send("#{paperclip_field_name}_file_name_fallback=", send("#{paperclip_field_name}_file_name"))
          end
        end
      end



      after_validation :normalize_slug


      before_save :normalize_release_date



      #if respond_to?(:translates?) && translates?

      #end
    end

    def has_seo_tags
      has_one :static_page_data, :as => :has_static_page_data
      accessible_nested_attributes_for :static_page_data, :allow_destroy => true

    end

    def my_translates *args
      configure_for_translations *args
      init_translation_class
    end

    def configure_for_translations *args
      #association_name = args.delete_at(0)
      translates *args
      accessible_nested_attributes_for :translations
    end

    def init_translation_class
      translation_class.class_eval do
        attr_accessible(*attribute_names)


        # from service.rb before_save
        before_save do
          if !self.slug || self.slug.length == 0
            if I18n.locale != :ru
              locale = I18n.locale
              I18n.locale = :ru
              self.slug = self.name.parameterize
              I18n.locale = locale
            end
          end
        end


      end
    end

    def accessible_all_attributes
      attr_accessible(*attribute_names)
    end

    def accessible_nested_attributes_for(*args_and_options)
      #attrs.each {|attr| attr_accessible attr, "#{attr}_attributes" }
      #attrs.each {|attr| attr_accessible attr, "#{attr}_attributes" }
      klass = self
      options = args_and_options.select.with_index {|o, i| i == args_and_options.length - 1 &&  args_and_options.last.is_a?(Hash) && args_and_options.last.extractable_options? }
      #args = args_and_options.select { |o| !(args_and_options.last.is_a?(Hash) && args_and_options.last.extractable_options?) }
      args = []
      args_and_options.each do |a|
        if !a.is_a?(Hash)
          args << a
        else
          break
        end
      end
      args.each {|attr| klass.attr_accessible attr, "#{attr}_attributes" }
      klass.accepts_nested_attributes_for *args_and_options
      #puts args.inspect
    end




  end



  # ==============================================
  # ----------------------------------------------
  # Instance methods
  # ----------------------------------------------
  # ==============================================



  def generate_title
    self.title ||= name
  end

  def self.remove_text_align_justify(fields = [])
    fields = [:content] if fields.try(&:empty?)
    ActiveRecord::Base.remove_text_align_justify(self, fields)
  end

  def generate_name
    self.name ||= "service-#{self.id}"
  end



  def normalize_slug
    if self.respond_to?(:slug)
      if self.name.present?
        self.slug = self.name.parameterize if self.slug.blank?
        self.translations_by_locale.each do |locale, t|
          t.slug = t.name.parameterize if t.slug.blank?
        end
      end
    end
  end

  def generate_static_page_data
    if self.respond_to?(:static_page_data)
      if static_page_data.nil?
        build_static_page_data
      end

      s = self.static_page_data

      if s.sitemap_element.nil?
        s.build_sitemap_element
      end

      e = s.sitemap_element

      s.translations_by_locale.each do |locale, t|
        #t.head_title
        #t.save
      end
    end
  end

  def normalize_release_date
    if self.respond_to?(:release_date)
    #self.short_description ||= 'my_default_short_description'
    #self.release_date ||= self.created_at
    #release_date = Date.yesterday
      self.release_date ||= DateTime.now
    end
  end
end

# def resolve_avatar_styles
#   example = {
#       thumb: {
#           processors: [:thumbnail, :optimizer_paperclip_processor],
#           geometry: '250x200#',
#           optimizer_paperclip_processor: {  }
#       },
#       item: {
#           processors: [:thumbnail, :optimizer_paperclip_processor],
#           geometry: '800x500#',
#           optimizer_paperclip_processor: {  }
#       }
#   }
#
#   field_name = "avatar"
#   content_type = send("#{field_name}_content_type")
#
#   #styles = { :thumb => '150x150>', :article_item => '320x320>', home_article_item: '250x250>', article_page: '500x500>'}
#
#
#   if content_type == "image/jpeg"
#
#   elsif content_type == "image/png"
#
#   end
#
#   styles
# end

