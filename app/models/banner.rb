class Banner < ActiveRecord::Base
  attr_accessible :published, :name, :description, :avatar

  has_attached_file :avatar

  # Paperclip image attachments
  has_attached_file :avatar, :styles => { :thumb => '150x150>' },
                    :url  => '/assets/banners/:id/:style/:basename.:extension',
                    :path => ':rails_root/public/assets/banners/:id/:style/:basename.:extension'
end
