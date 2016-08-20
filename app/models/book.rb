class Book < ActiveRecord::Base
  belongs_to :owner, :class_name => "User"
  belongs_to :rent_by, :class_name => "User"
end
