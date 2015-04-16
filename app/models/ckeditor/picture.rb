class Ckeditor::Picture < Ckeditor::Asset
  include PaperclipEnhancements::InstanceMethods
  extend PaperclipEnhancements::ClassMethods


  has_paperclip_attached_file :data,
                    url: "/ckeditor_assets/pictures/:id/:style_:basename.:extension",
                    path: ":rails_root/public/:url"
                    #styles: proc { |a| a.instance.resolve_data_styles },
                    #processors: [:thumbnail, :paperclip_optimizer]

  validates_attachment_size :data, :less_than => 10.megabytes
  validates_attachment_presence :data

  def url_content
    url(:content)
  end

  def resolve_data_styles
    styles = {
        :content => {
            processors: [],
            geometry: '10000x10000>',
            optimizer_paperclip_processor: {  }
        },
        :thumb => {
            geometry: '118x100#'
        }
    }

    self.class.with_webp_styles! styles

    styles
  end




end


