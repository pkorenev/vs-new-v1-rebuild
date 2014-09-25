class CodePage < ActiveRecord::Base
  attr_accessible :file_path, :code

  rails_admin do
    edit do
      field :file_path
      field :code, :code_mirror do
       config mode: 'yaml', theme: 'neo'
      end
    end
  end
end
