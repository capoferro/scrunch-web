class Encounter < ActiveRecord::Base

  belongs_to :combat_log
  has_many :entities

end
