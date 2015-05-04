module Paperclip
  class Paperclip::OptimizerPaperclipProcessor < Processor
    def initialize file, options = {}, attachment = nil
      super
     # puts "options: #{attachment.inspect}"


      @file           = file
      @options        = options
      @instance       = attachment.instance
      @current_format = File.extname(@file.path)
      @basename       = File.basename(@file.path, @current_format)
      @whiny          = options[:whiny].nil? ? true : options[:whiny]
      @attachment_content_type = attachment.content_type

      puts "file_path: #{@file.path}"
      puts "format: #{@attachment_content_type}"

      puts "options: #{options.inspect}"
    end
    #
    def make
      @disabled = true
      #puts "OptimizerPaperclipProcessor"
      src = @file
      #out_path = @basename

      compressed = false

      dst_format = options[:format] ? ".\#{options[:format]}" : ''
      #dst = Tempfile.new([basename, dst_format])
      dst = Tempfile.new(".jpg")
      out_path = File.expand_path(dst.path)
      in_path = File.expand_path(src.path)
      dst.binmode
      #dst = Tempfile.new([@basename, @format ? ".#{@format}" : ''])
      if @disabled

      elsif @attachment_content_type == "image/jpeg"
        optimize_jpeg_with_jpegrecompress({in: in_path, out: out_path})
        compressed = true
      elsif @attachment_content_type == "image/png"
        optimize_png_with_pngquant({in: in_path, out: out_path})
        compressed = true
      elsif @attachment_content_type == "image/svg+xml"
        #puts "@attachment_content_type = #{@attachment_content_type}"
        optimize_svg_with_svgo(in_path, out_path)
        compressed = true
      end

      compressed ? dst : src
    end

    def optimize_png_with_pngquant(args = {}, options = {})
      default_args = {
          in: "",
          out: ""
      }
      args = default_args.merge(args)

      default_options = {
          in: "",
          out: ""
      }
      options = default_options.deep_merge(options)

      in_path = args[:in]
      out_path = args[:out]

      cmd_args = [in_path]
      cmd_options = {
          output: out_path,
          force: ""
      }

      bin = "pngquant"
      cmd = "#{bin} #{cmd_options.map{|key, value| "--#{key} #{value}" }.join(" ")} #{cmd_args.map(&:to_s).join(" ")}"

      system cmd
      puts "command: #{cmd}"
    end

    def optimize_jpeg_with_jpegrecompress(args = {}, options = {})
      #puts "optimize_jpeg_with_jpegrecompress"
      args ||= {}

      default_args = {
          in: "",
          out: ""
      }

      args = default_args.merge(args)

      defaults = {
          quality: 0,
          min: 0,
          accurate: true,
          strip: true,
          no_copy: true
      }

      options = defaults.deep_merge(options)

      in_path = args[:in]
      out_path = args[:out]

      #puts "tool: jpeg-recompress"



      jpeg_recompress_quality_names = %w(low medium high veryhigh)

      bin = "jpeg-recompress"

      cmd_options = {
          quality: jpeg_recompress_quality_names[options[:quality]],
          min: options[:min],
          accurate: ( "" if options[:accurate] ),
          strip: ("" if options[:strip]),
          :"no-copy" => ("" if options[:no_copy])
      }.delete_if{ |k,v| v.nil? }

      cmd_args = [in_path, out_path]

      cmd = "#{bin} #{cmd_options.map{|key, value| "--#{key} #{value}" }.join(" ")} #{cmd_args.map(&:to_s).join(" ")}"



      system cmd
      puts "command: #{cmd}"

    end

    def optimize_jpeg_with_jpegoptim
      bin = "jpegoptim"
      cmd = "#{bin} #{in_path} #{out_path}"
      puts "command: #{cmd}"
      system cmd
    end

    def optimize_svg_with_svgo(in_path, out_path)
      bin = "svgo"
      cmd = "#{bin} #{in_path} #{out_path}"
      puts "command: #{cmd}"
      system cmd
    end

    #def make
    #  dest = Tempfile.new(".jpg")
    #end

    def a
      make
    end
  end
end