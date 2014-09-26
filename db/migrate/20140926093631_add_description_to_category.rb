class AddDescriptionToCategory < ActiveRecord::Migration
  def change
    model = Portfolio::PortfolioCategory
    ([model] + (translation_class = []; if model.respond_to?(:translates?) && model.translates? then; translation_class.push model.translation_class ; end; translation_class)).each do |m|
      change_table m.table_name do |t|
        t.text :full_description
        t.text :short_description
      end
    end
  end
end
