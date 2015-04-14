module Resource
  #extend ActiveSupport::Concern
	# @dependent_resources = []
	# @affected_resources = []

  # included do
  #   attr_accessible(*attribute_names)
  #
  # end

  # better_included do
  #   attr_accessible(*attribute_names)
  #
  #   before_validation do
  #     paperclip_field_names.each do |paperclip_field_name|
  #       if self.send("delete_#{paperclip_field_name}") == '1'
  #         self.send(paperclip_field_name).clear
  #         self.send("#{paperclip_field_name}_file_name_fallback=", send("#{paperclip_field_name}_file_name"))
  #       end
  #     end
  #   end
  # end

  # def self.my_included(&block)
  #   block.call
  # end

  def self.included(klass)
    klass.extend Resource::ClassMethods
    klass.class_eval(&:my_included)

    # klass.attr_accessible(*klass.attribute_names)
    # klass.before_validation do
    #   klass.paperclip_field_names.each do |paperclip_field_name|
    #     if self.send("delete_#{paperclip_field_name}") == '1'
    #       self.send(paperclip_field_name).clear
    #       self.send("#{paperclip_field_name}_file_name_fallback=", send("#{paperclip_field_name}_file_name"))
    #     end
    #   end
    # end
  end

  def initialize
    #attr_accessible(*attribute_names)
    #attr_accessible(*attribute_names)
  end

  # def self.included(klass = nil)
  #   super
  #   #puts "included module Metadata to class #{klass}"
  #   #klass.attr_accessible(kla)
  #
  #   klass.attr_accessible :name
  # end



  module ClassMethods
    attr_accessor :_paperclip_field_names

    def my_included
      attr_accessible(*attribute_names)
      before_validation do
        klass = self.class
        klass.paperclip_field_names.each do |paperclip_field_name|
          if self.send("delete_#{paperclip_field_name}") == '1'
            self.send(paperclip_field_name).clear
            self.send("#{paperclip_field_name}_file_name_fallback=", send("#{paperclip_field_name}_file_name"))
          end
        end
      end
    end

    def accessible_nested_attributes_for(*attrs)
      #attrs.each {|attr| attr_accessible attr, "#{attr}_attributes" }
      attrs.each {|attr| attr_accessible attr, "#{attr}_attributes" }
    end



    def init_paperclip_fields(*fields)
      @_paperclip_field_names = fields
      fields.each do |paperclip_field_name|
        attr_accessible paperclip_field_name.to_sym, "delete_#{paperclip_field_name}".to_sym, "#{paperclip_field_name}_file_name".to_sym, "#{paperclip_field_name}_file_size".to_sym, "#{paperclip_field_name}_content_type".to_sym, "#{paperclip_field_name}_updated_at".to_sym, "#{paperclip_field_name}_file_name_fallback".to_sym, "#{paperclip_field_name}_alt".to_sym

        attr_accessor "delete_#{paperclip_field_name}".to_sym
      end


      #
      # #before_save { self.detect_rename_avatar2 }
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

  #module InstanceMethods

  def detect_rename_avatar
    folder_names = avatar.styles.keys
    folder_names.push('original')
    #self.avatar_file_name = "vs-logo-1.jpg#{folder_names.count}"

    if avatar_file_name_changed?
      if !new_record?
        old_name = self.avatar_file_name_was
        new_name = self.avatar_file_name

        original_folder_name = 'original'

        original_old_file_path = avatar.path(original_folder_name)
        original_new_file_path = original_old_file_path

        original_old_file_path_array = original_old_file_path.split('/')
        original_old_file_path_array[original_old_file_path_array.count - 1] = old_name
        original_old_file_path = original_old_file_path_array.join('/')

        if !File.exist?(original_old_file_path)
          self.avatar_file_name = old_name
        else
          folder_names.each do |folder_name|
            old_file_path = avatar.path(folder_name)
            new_file_path = old_file_path

            old_file_path_array = old_file_path.split('/')
            old_file_path_array[old_file_path_array.count - 1] = old_name
            old_file_path = old_file_path_array.join('/')





            if File.exist?(old_file_path) && !File.exist?(new_file_path)
              FileUtils.mv(old_file_path, new_file_path)

            end
          end
        end



      else

      end

    end
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





  #end





  #
  #
  # def render_dependent_resources
  #
  # end
  #
  # def affects_on *args
  # 	self
  # end


end	



###########################
#######################
##########################

#"article"=>{"published"=>"1", "translations_attributes"=>{"0"=>{"locale"=>"uk", "published"=>"0", "name"=>"Наша команда1", "slug"=>"nasha-komanda", "short_description"=>"fg", "content"=>"", "avatar_alt"=>"", "id"=>"23"}, "1"=>{"locale"=>"en", "published"=>"0", "name"=>"Geography", "slug"=>"geography", "short_description"=>"fgf", "content"=>"", "avatar_alt"=>"", "id"=>"24"}, "2"=>{"locale"=>"ru", "published"=>"0", "name"=>"test", "slug"=>"test", "short_description"=>"fgfg", "content"=>"", "avatar_alt"=>"", "id"=>"22"}}, "portfolio_tag_scope_attributes"=>{"_destroy"=>"false", "tag_list"=>"", "id"=>"41"}, "release_date"=>"13 апреля 2015, 21:56", "author"=>"", "delete_avatar"=>"1", "avatar_file_name_fallback"=>""}, "return_to"=>"http://localhost:4000/admin/article/21/", "_add_edit"=>"", "model_name"=>"article", "id"=>"21"}