class User < ActiveRecord::Base
  has_many :players
  has_secure_password
  validates_presence_of :email, :username, :password
  validates_uniqueness_of :email, :username

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end

end #end of the User class
