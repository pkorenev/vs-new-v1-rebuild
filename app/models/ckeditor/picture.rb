class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
                    :url  => "/ckeditor_assets/pictures/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/ckeditor_assets/pictures/:id/:style_:basename.:extension",
                    :styles => { 
                    	:content => '8000x8000>', 
                    	:thumb => '118x100#', 
                    	better_content: {geometry: "1600x1600>", paperclip_optimizer: { jpegrecompress: { quality: 3 } } } 
                    	},
                    processors: [:thumbnail, :paperclip_optimizer]

  validates_attachment_size :data, :less_than => 10.megabytes
  validates_attachment_presence :data

  def url_content
    url(:content)
  end
end
