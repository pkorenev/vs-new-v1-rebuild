class Developer < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :facebook_profile, :vkontakte_profile, :twitter_profile, :developer_role_id

  belongs_to :developer_role

  # Paperclip image attachments
  has_attached_file :avatar, :styles => { :thumb => '150x150>' },
                    :url  => '/assets/developers/:id/:style/:basename.:extension',
                    :path => ':rails_root/public/assets/developers/:id/:style/:basename.:extension'

  [:avatar].each do |paperclip_field_name|
    attr_accessible paperclip_field_name.to_sym, "delete_#{paperclip_field_name}".to_sym, "#{paperclip_field_name}_file_name".to_sym, "#{paperclip_field_name}_file_size".to_sym, "#{paperclip_field_name}_content_type".to_sym, "#{paperclip_field_name}_updated_at".to_sym, "#{paperclip_field_name}_file_name_fallback".to_sym, "#{paperclip_field_name}_alt".to_sym

    attr_accessor "delete_#{paperclip_field_name}".to_sym
  end



  def get_full_name
  	return self.first_name + ' ' + self.last_name
  end
  rails_admin do
  	object_label_method do
    	:get_full_name
  	end

  	list do
  		field :first_name do
  			label 'Имя'
  		end

  		field :last_name do
  			label 'Фамилия'
  		end

  		field :email

  		field :avatar

  		field :developer_role
  	end

  	edit do
  		field :first_name do
  			label 'Имя'
  		end

  		field :last_name do
  			label 'Фамилия'
  		end

  		field :email

      group :image_data do
        field :avatar, :paperclip
        field :avatar_file_name_fallback
      end

  		field :developer_role

  		field :facebook_profile
  	end
  end
end
