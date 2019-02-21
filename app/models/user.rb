class User < ActiveRecord::Base

  has_many :fitness_classes
  has_secure_password

  #validates_uniqueness_of :username, :case_sensitive => false, :on => :create, message: "is already taken"

end
