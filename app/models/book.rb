class Book < ActiveRecord::Base
  belongs_to :owner, :class_name => "User"
  belongs_to :rent_by, :class_name => "User"
  validates_presence_of :author, :message => "Ksiązka musi mieć podanego autora"
  validates_presence_of :name, :message => "Ksiązka musi mieć podany tytuł"



  # def self.search(search)
  # 	if search
  # 		where(["author OR name LIKE ?", "%#{search}%"])
  # 	else 
  # 		all
  # 	end
  # end
end
