class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
                    url: "/ckeditor_assets/pictures/:id/:style_:basename.:extension",
                    path: ":rails_root/public/:url",
                    styles: proc { |a| a.instance.resolve_data_styles },
                    processors: [:thumbnail, :paperclip_optimizer]

  validates_attachment_size :data, :less_than => 10.megabytes
  validates_attachment_presence :data

  def url_content
    url(:content)
  end

  def resolve_data_styles
    styles = {
        :content => {
            processors: [:thumbnail, :optimizer_paperclip_processor],
            geometry: '1600x1600>',
            optimizer_paperclip_processor: {  }
        },
        :thumb => '118x100#'
    }

    styles
  end


end


