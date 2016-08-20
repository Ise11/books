class Book < ActiveRecord::Base
  belongs_to :owner, :class_name => "User"
  belongs_to :rent_by, :class_name => "User"

  # def self.search(search)
  # 	if search
  # 		where(["author OR name LIKE ?", "%#{search}%"])
  # 	else 
  # 		all
  # 	end
  # end
end
