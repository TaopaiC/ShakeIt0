class User < ActiveRecord::Base
  has_many :participants
  has_many :rooms, :through => :participants
  devise :database_authenticatable, :rememberable, :registerable
end
