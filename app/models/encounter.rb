class Encounter < ActiveRecord::Base

  belongs_to :combat_log
  has_many :entities
  has_one :owner, class_name: 'Entity'

end
