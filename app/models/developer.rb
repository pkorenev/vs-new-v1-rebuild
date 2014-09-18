class Developer < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :avatar, :facebook_profile, :vkontakte_profile, :twitter_profile, :developer_role_id
  has_attached_file :avatar

  belongs_to :developer_role

  # Paperclip image attachments
  has_attached_file :avatar, :styles => { :thumb => '150x150>' },
                    :url  => '/assets/developers/:id/:style/:basename.:extension',
                    :path => ':rails_root/public/assets/developers/:id/:style/:basename.:extension'



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

  		field :avatar

  		field :developer_role

  		field :facebook_profile
  	end
  end
end
