class Room < ActiveRecord::Base
  has_many :participants
end
