class Forms::Order < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :phone
  attr_accessible :organization_name
  attr_accessible :email
  attr_accessible :money
  attr_accessible :text
end
