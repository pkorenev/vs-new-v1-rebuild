Paperclip::Interpolations[:style_url] = proc do |attachment, style|
  # or whatever you've named your User's login/username/etc. attribute
  attachment.instance.url_per_style(style)
end
#
# Paperclip::Attachment.default_options.merge!(
#     #path: ":resource"
# )

