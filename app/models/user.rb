class User < ActiveRecord::Base

  has_many :fitness_classes
  has_secure_password

end
