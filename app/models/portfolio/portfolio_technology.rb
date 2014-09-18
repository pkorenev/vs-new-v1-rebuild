class Portfolio::PortfolioTechnology < ActiveRecord::Base
  attr_accessible :name, :official_link, :avatar, :avatar_file_name, :avatar_file_size, :avatar_updated_at, :avatar_content_type, :delete_avatar

  attr_accessor :delete_avatar

  has_attached_file :avatar, :styles => { :icon32 => '32x32>', :icon48 => '48x48>', :icon64 => '64x64>'},
                  :url  => '/assets/portfolio/technologies/:id/:style/:basename.:extension',
                  :path => ':rails_root/public/assets/portfolio/technologies/:id/:style/:basename.:extension'
                  #:hash_secret => '3858f62230ac3c915f300c664312c63f'

  rails_admin do
   edit do
   	field :name
   	field :official_link
   	field :avatar, :paperclip
   end
  end
end
