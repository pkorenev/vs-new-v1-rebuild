class Service < ActiveRecord::Base
  attr_accessible :sort_id, :published, :name, :short_description, :full_description, :avatar, :delete_avatar, :avatar_file_name, :avatar_file_name_fallback, :avatar_alt, :slug
  has_attached_file :avatar
  validates :sort_id, :uniqueness => true, :presence => true


  attr_accessor :delete_avatar
  before_validation {
    if self.delete_avatar == '1'
      self.avatar.clear;
      self.avatar_file_name_fallback = avatar_file_name;
    end
  }




  belongs_to :services_page, :class_name => 'Pages::ServicesPage'
  attr_accessible :services_page, :services_page_id

  before_validation :configure_sort_id

  def configure_sort_id
    sort_id ||= id
  end

  before_validation :generate_slug
  before_validation :generate_name

  def generate_slug
    self.slug ||= self.name.parameterize
  end

  def generate_name
    self.name ||= "service-#{self.id}"
  end

  before_save :detect_rename_avatar

  def detect_rename_avatar

    #self.avatar_file_name_fallback = 'hello'

    if !avatar_file_name_fallback || avatar_file_name_fallback == ''
      self.avatar_file_name_fallback = avatar_file_name
    end



    if self.avatar_file_name != self.avatar_file_name_fallback && self.avatar.exists?



      folder_names = avatar.styles.keys
      folder_names.push('original')
      #self.avatar_file_name = "vs-logo-1.jpg#{folder_names.count}"

      if avatar_file_name_fallback_changed? && avatar_file_name_fallback_was != nil
        if !new_record?


        old_name = avatar_file_name_fallback_was
        new_name = avatar_file_name_fallback

        original_folder_name = 'original'

        original_old_file_path = avatar.path(original_folder_name)
        original_old_file_path_array = original_old_file_path.split('/')
        original_old_file_path_array[original_old_file_path_array.count - 1] = old_name


        original_new_file_path = avatar.path(original_folder_name)
        original_new_file_path_array = original_new_file_path.split('/')
        original_new_file_path_array[original_new_file_path_array.count - 1] = new_name

        #if original_old_file_path


          original_old_file_path = original_old_file_path_array.join('/')


          if original_old_file_path != original_new_file_path

          if !File.exist?(original_old_file_path)
            self.avatar_file_name_fallback = old_name
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

            self.avatar_file_name_fallback = "#{original_new_file_path == original_old_file_path}"

            #self.avatar_file_name = new_name
          end

          end

        #end


        else

        end

      end
    end
  end

  rails_admin do
   list do
   field :sort_id do
     #label 'id'
    end
    field :published
    field :name
    field :short_description
    field :avatar
   end
   edit do
    field :sort_id do
     #label 'id'
    end
    field :published
    field :name
    field :slug do
      label 'url part'
    end
    field :short_description
    field :full_description, :ck_editor

    field :avatar do
      group :image_data
    end
    field :avatar_alt do
      group :image_data
    end
    field :avatar_file_name_fallback do
      group :image_data
      label 'file name'
    end
     field :services_page

   end
  end
end
