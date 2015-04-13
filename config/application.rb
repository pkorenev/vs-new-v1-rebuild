require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module StudioVoronin
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en
    config.i18n.available_locales = [:uk, :en, :ru]

    config.i18n.fallbacks = true

    Globalize.fallbacks = {:en => [:uk, :ru], :ru => [:uk, :en], uk: [:ru, :en] }

    #config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
    config.assets.precompile = []
    config.assets.precompile += Ckeditor.assets
    config.assets.precompile += %w(app.css application.js zoomico.png jquery.js )
    #config.assets.precompile += %w(voronin-studio-logo.png)
    #config.assets.precompile += %w(contact-compiler.css)

    #config.assets.precompile += %w(footer-get-top.jpg behance_footer.jpg)

    #config.assets.precompile += %w(favicon.ico)

    # add banners images
    config.assets.precompile += %w(banners/* static_images/* portfolio/*)

    config.assets.precompile += %w(ckeditor)
    config.assets.precompile += %w(rails_admin/rails_admin.css rails_admin/rails_admin.css)

    config.assets.precompile += %w(fonts/*, fontawesome*)

    config.assets.precompile += %w(file_editor_application.css, file_editor_application.js)

    # august
    #config.assets.precompile += %w(jquery-ui/ui-bg_flat_75_ffffff_40x100.png)


    config.assets.precompile += ["jquery-ui/ui-bg_flat_75_ffffff_40x100.png",
     "jquery-ui/ui-bg_highlight-soft_75_cccccc_1x100.png",
     "jquery-ui/ui-bg_glass_75_e6e6e6_1x400.png",
     "jquery-ui/ui-bg_glass_75_dadada_1x400.png",
     "jquery-ui/ui-bg_glass_65_ffffff_1x400.png",
     "jquery-ui/ui-bg_glass_55_fbf9ee_1x400.png",
     "jquery-ui/ui-bg_glass_95_fef1ec_1x400.png",
     "jquery-ui/ui-icons_222222_256x240.png",
     "jquery-ui/ui-icons_888888_256x240.png",
     "jquery-ui/ui-icons_454545_256x240.png", "jquery-ui/ui-icons_2e83ff_256x240.png", "jquery-ui/ui-icons_cd0a0a_256x240.png", "jquery-ui/ui-bg_flat_0_aaaaaa_40x100.png"]

    config.assets.precompile += %w(rails_admin/colorpicker/*.gif rails_admin/colorpicker/*.png rails_admin/bootstrap/*.png rails_admin/aristo/images/* rails_admin/multiselect/*.png rails_admin/*.png)


    config.assets.precompile += %w(ckeditor/config.js)
    config.assets.precompile += %w(ckeditor/plugins/codemirror/plugin.js ckeditor/plugins/codemirror/lang/* ckeditor/plugins/codemirror/css/* ckeditor/plugins/codemirror/js/*.js ckeditor/plugins/codemirror/icons/* ckeditor/plugins/codemirror/theme/*)


    config.assets.compile = true

    html_compressor_options = {
  :enabled => true,
  :remove_multi_spaces => true,
  :remove_comments => true,
  :remove_intertag_spaces => false,
  :remove_quotes => false,
  :compress_css => false,
  :compress_javascript => false,
  :simple_doctype => false,
  :remove_script_attributes => false,
  :remove_style_attributes => false,
  :remove_link_attributes => false,
  :remove_form_attributes => false,
  :remove_input_attributes => false,
  :remove_javascript_protocol => false,
  :remove_http_protocol => false,
  :remove_https_protocol => false,
  :preserve_line_breaks => false,
  :simple_boolean_attributes => false,
  :compress_js_templates => false
}

    config.middleware.use Rack::PageCaching
    config.middleware.use HtmlCompressor::Rack, html_compressor_options

  end
end
