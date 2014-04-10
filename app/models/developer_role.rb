class DeveloperRole < ActiveRecord::Base
  attr_accessible :developer_ids, :name

  has_many :developers
end
