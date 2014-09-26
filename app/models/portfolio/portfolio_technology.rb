class Portfolio::PortfolioTechnology < ActiveRecord::Base
  attr_accessible :name, :official_link

  has_attached_file :avatar, :styles => { :icon32 => '32x32>', :icon48 => '48x48>', :icon64 => '64x64>'},
                  :url  => '/assets/portfolio/technologies/:id/:style/:basename.:extension',
                  :path => ':rails_root/public/assets/portfolio/technologies/:id/:style/:basename.:extension'
                  #:hash_secret => '3858f62230ac3c915f300c664312c63f'

  [:avatar].each do |paperclip_field_name|
    attr_accessible paperclip_field_name.to_sym, "delete_#{paperclip_field_name}".to_sym, "#{paperclip_field_name}_file_name".to_sym, "#{paperclip_field_name}_file_size".to_sym, "#{paperclip_field_name}_content_type".to_sym, "#{paperclip_field_name}_updated_at".to_sym, "#{paperclip_field_name}_file_name_fallback".to_sym, "#{paperclip_field_name}_alt".to_sym

    attr_accessor "delete_#{paperclip_field_name}".to_sym
  end

  rails_admin do
   edit do
   	field :name
   	field :official_link
    group :image_data do
      field :avatar, :paperclip
      field :avatar_file_name_fallback
    end
   end
  end
end
