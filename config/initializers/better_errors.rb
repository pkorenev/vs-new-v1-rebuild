if defined? BetterErrors
  BetterErrors.editor = proc { |full_path, line|
    #full_path = full_path.sub(Rails.root.to_s, your_local_path)
    #"mine://open?url=file://#{full_path}&line=#{line}"
    #BetterErrors.editor = "rubymine://open/?url=file:/#{full_path}&line=#{line}" if defined? BetterErrors
    BetterErrors.editor = "rubymine:/open?url=file:#{full_path}&line=#{line}" if defined? BetterErrors
  }
end