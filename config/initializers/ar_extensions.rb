class ActiveRecord::Base
  def self.remove_text_align_justify(model, fields)

    #model = self

    #[:full_description].each {|model| if model.respond_to?(:translates) && model.respond_to?() }
    #Article::Translation.all.each {|t| t.content = t.content.gsub(/<h1[\s]{0,}>[\s]{0,}<em[\s]{0,}>[\s]{0,}/i, '<h3>').gsub(/<\/h1[\s]{0,}>[\s]{0,}<\/em[\s]{0,}>[\s]{0,}/i, '</h3>');  t.save }
    #Article::Translation.all.each {|t| t.content = t.content.gsub(/<h1[\s]{0,}>[\s]{0,}<em[\s]{0,}>[\s]{0,}/i, '<h3>').gsub(/<\/h1[\s]{0,}>[\s]{0,}<\/em[\s]{0,}>[\s]{0,}/i, '');  t.save }
    #fields = [:full_description] if fields.try(&:empty?)
    if model.respond_to?(:translates?) && model.translates?
      model_translation_class = model.translation_class
    end
    model_translation_class.all.each {|t| fields.each {|field_name|  new_content = t.send(field_name).gsub(/text-align[\s]{0,}:[\s]{0,}justify/, '').gsub(/style[\s]{0,}=[\s]{0,}"[\s;]{0,}"/, ''); t.send("#{field_name}=", new_content);  }; t.save }
  end
end