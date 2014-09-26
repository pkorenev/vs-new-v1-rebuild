class AddImageFieldsToModels < ActiveRecord::Migration
  def change
    [Service, Article, TrustCompany, Portfolio::Portfolio, Portfolio::PortfolioTechnology, Developer].each do |model|
      table_columns = model.connection.columns(model.table_name)
      column_names = []
      table_columns.each do |c|
        column_names.push c.name.to_sym
      end


      change_table model.table_name do |t|
        if !column_names.include?(:avatar_alt)
          t.string :avatar_alt
        end
      end
    end

    change_table Portfolio::PortfolioBanner.table_name do |t|
      table_columns = ActiveRecord::Base.connection.columns(Portfolio::PortfolioBanner.table_name)
      column_names = []
      table_columns.each do |c|
        column_names.push c.name.to_sym
      end

      if !column_names.include?(:background_alt)
      t.string :background_alt

      end
    end

    change_table Portfolio::Portfolio.table_name do |t|
      table_columns = ActiveRecord::Base.connection.columns(Portfolio::Portfolio.table_name)
      column_names = []
      table_columns.each do |c|
        column_names.push c.name.to_sym
      end

      if !column_names.include?(:thanks_image_alt)
        t.string :thanks_image_alt
      end

      if !column_names.include?(:thanks_image_file_name_fallback)
        t.string :thanks_image_file_name_fallback
      end
    end

    [Service, Article, TrustCompany, Portfolio::Portfolio, Portfolio::PortfolioTechnology, Developer].each do |model|
      if ActiveRecord::Base.connection.tables.include?(model.table_name)
        model.all.each do |obj|
          obj.avatar_file_name_fallback = obj.avatar_file_name
          obj.save
        end
      end
    end

    [Portfolio::Portfolio].each do |model|
      if ActiveRecord::Base.connection.tables.include?(model.table_name)
        model.all.each do |obj|
          obj.thanks_image_file_name_fallback = obj.thanks_image_file_name
          obj.save
        end
      end
    end
  end
end
