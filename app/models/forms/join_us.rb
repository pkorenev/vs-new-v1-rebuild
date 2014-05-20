class Forms::JoinUs < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :phone
  attr_accessible :vacancy
  attr_accessible :email
  attr_accessible :attachment
  attr_accessible :text
end
