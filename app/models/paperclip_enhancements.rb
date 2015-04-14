module PaperclipEnhancements
  module ClassMethods
    def has_paperclip_attached_file *args
      attrs = args.select {|attr| !attr.is_a?(Hash) || !attr.extractable_options? }
      init_paperclip_fields(*attrs)
      has_attached_file *args
    end



    def init_paperclip_fields(*fields)
      @_paperclip_field_names ||= []
      fields.each do |field|
        @_paperclip_field_names << field.to_sym if @_paperclip_field_names.index(field.to_sym).nil?
      end

      fields.each do |paperclip_field_name|
        attr_accessible paperclip_field_name.to_sym, "delete_#{paperclip_field_name}".to_sym, "#{paperclip_field_name}_file_name".to_sym, "#{paperclip_field_name}_file_size".to_sym, "#{paperclip_field_name}_content_type".to_sym, "#{paperclip_field_name}_updated_at".to_sym, "#{paperclip_field_name}_file_name_fallback".to_sym, "#{paperclip_field_name}_alt".to_sym

        attr_accessor "delete_#{paperclip_field_name}".to_sym
      end


      before_save :detect_rename_avatar2
    end

    def paperclip_field_names
      attrs = @_paperclip_field_names #self._accessible_attributes[:default]
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

    def reprocess_all!(paperclip_instance_names = nil)
      names = nil
      if paperclip_instance_names.nil?
        # if self.respond_to?(:paperclip_instance_names)
        #   paperclip_instance_names = self.paperclip_instance_names
        # else
        #   paperclip_instance_names = [:avatar]
        # end
        paperclip_instance_names = self.paperclip_field_names
      end
      self.all.each do |item|
        paperclip_instance_names.each do |paperclip_instance_name|
          item.send(paperclip_instance_name).reprocess!
        end
      end
    end
  end

  module InstanceMethods
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
  end
end