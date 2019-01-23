class Player < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name, :team, :position, message: " can not be blank!"
  validates_uniqueness_of :name, scope: :user_id, message: " can not be a duplicate of someone already on your team"
  validates_format_of :name, with: /\A[A-Z\sa-z]+\z/, message: "of player must only have letters and spaces"
end
