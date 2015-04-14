module Resource
  def self.included(klass)
    klass.extend Resource::ClassMethods
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
      accepts_nested_attributes_for :static_page_data, :allow_destroy => true

    end

    def my_translates *args
      configure_for_translations *args
      init_translation_class
    end

    def configure_for_translations *args
      #association_name = args.delete_at(0)
      translates *args
      accepts_nested_attributes_for :translations
      attr_accessible :translations, :translations_attributes
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
      options = args_and_options.select.with_index {|o, i| i == args_and_options.length - 1 &&  args_and_options.last.is_a?(Hash) && args_and_options.last.extractable_options? }
      args = args_and_options.select { |o| !(args_and_options.last.is_a?(Hash) && args_and_options.last.extractable_options?) }
      args.each {|attr| attr_accessible attr, "#{attr}_attributes" }
      accepts_nested_attributes_for *args_and_options
    end

    def has_paperclip_attached_file *args
      attrs = args.select {|attr| !attr.is_a?(Hash) || !attr.extractable_options? }
      init_paperclip_fields(*attrs)
      has_attached_file *args
    end



    def init_paperclip_fields(*fields)
      @_paperclip_field_names = fields
      fields.each do |paperclip_field_name|
        attr_accessible paperclip_field_name.to_sym, "delete_#{paperclip_field_name}".to_sym, "#{paperclip_field_name}_file_name".to_sym, "#{paperclip_field_name}_file_size".to_sym, "#{paperclip_field_name}_content_type".to_sym, "#{paperclip_field_name}_updated_at".to_sym, "#{paperclip_field_name}_file_name_fallback".to_sym, "#{paperclip_field_name}_alt".to_sym

        attr_accessor "delete_#{paperclip_field_name}".to_sym
      end


      before_save :detect_rename_avatar2
    end

    def paperclip_field_names
      attrs = @_paperclip_field_names.map(&:to_s) #self._accessible_attributes[:default]
      # paperclip_fields = []
      # attrs.each do |attr_name|
      #
      #   parts = attr_name.scan(/(\w{1,})(_file_name|_file_size|_content_type|_updated_at)/)
      #   if parts.count == 1 && parts.first.count == 2
      #     field_name = parts.first.first
      #     if respond_to?(field_name.to_sym) && send(field_name).class.to_s.scan(/Paperclip/).count > 0
      #       if !paperclip_fields.include?(field_name.to_sym)
      #         paperclip_fields.push field_name.to_sym
      #       end
      #     end
      #   end
      # end

      attrs
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

  def detect_rename_avatar2


    self.class.paperclip_field_names.each do |paperclip_field_name|

      result_file_name = send "#{paperclip_field_name}_file_name"

      if self.send("#{paperclip_field_name}_file_name_changed?") && !self.send("#{paperclip_field_name}_file_name").nil? # file uploaded: new or updated
        if send("#{paperclip_field_name}_file_name_fallback") && send("#{paperclip_field_name}_file_name_fallback").match(/\w{1,}(\.\w{3,4})/)
          result_file_name = send("#{paperclip_field_name}_file_name_fallback")
          self.send("#{paperclip_field_name}_file_name=", result_file_name)
        else
          self.send("#{paperclip_field_name}_file_name_fallback=", send("#{paperclip_field_name}_file_name"))
        end


      elsif !self.send("#{paperclip_field_name}_file_name_changed?") && self.send(paperclip_field_name).exists? && self.send("#{paperclip_field_name}_file_name_fallback_changed?") #rename existing file
        if send("#{paperclip_field_name}_file_name_fallback") && send("#{paperclip_field_name}_file_name_fallback").match(/\w{1,}(\.\w{3,4})/) # valid name
          result_file_name = self.send("#{paperclip_field_name}_file_name_fallback")
          self.send("#{paperclip_field_name}_file_name=", result_file_name)

          old_file_name = self.send("#{paperclip_field_name}_file_name_was")
          new_file_name = self.send("#{paperclip_field_name}_file_name")

          folder_names = send(paperclip_field_name).styles.keys
          folder_names.push 'original'
          folder_names.each do |folder_name|
            new_file_path = send(paperclip_field_name).path(folder_name.to_s)
            old_file_path_array = new_file_path.split('/')
            old_file_path_array[old_file_path_array.count - 1] = old_file_name
            old_file_path = old_file_path_array.join('/')

            # do rename

            if File.exist?(old_file_path) && !File.exist?(new_file_path)
              FileUtils.mv(old_file_path, new_file_path)
            end
          end
        else
          result_file_name = self.send("#{paperclip_field_name}_file_name")
          self.send("#{paperclip_field_name}_file_name_fallback=", result_file_name)
        end
      end
    end
  end

  def normalize_slug
    if self.name.present?
      self.slug = self.name.parameterize if self.slug.blank?
      self.translations_by_locale.each do |locale, t|
        t.slug = t.name.parameterize if t.slug.blank?
      end
    end
  end

  def generate_static_page_data
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

  def normalize_release_date
    if self.respond_to?(:release_date)
    #self.short_description ||= 'my_default_short_description'
    #self.release_date ||= self.created_at
    #release_date = Date.yesterday
      self.release_date ||= DateTime.now
    end
  end
end	



