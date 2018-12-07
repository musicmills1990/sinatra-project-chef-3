class User < ActiveRecord::Base
has_secure_password
has_many :ingredients
has_many :recipess

end
