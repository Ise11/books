class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :owned, :class_name => "Book", :foreign_key  => "owned_id"
  has_many :rented, :class_name => "Book", :foreign_key  => "rented_id"
end
