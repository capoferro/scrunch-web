class Encounter < ActiveRecord::Base

  belongs_to :combat_log
  has_many :entities
  has_one :owner, class_name: 'Entity'


  def total_damage
    self.class.total_of_attribute entities, :total_damage
  end

  def total_healing
    self.class.total_of_attribute entities, :total_healing
  end

  def total_mob_damage
    self.class.total_of_attribute entities.select(&:mob?), :total_damage
  end

  def total_mob_healing
    self.class.total_of_attribute entities.select(&:mob?), :total_healing
  end

  def total_player_damage
    self.class.total_of_attribute entities.select(&:player?), :total_damage
  end

  def total_player_healing
    self.class.total_of_attribute entities.select(&:player?), :total_healing
  end

  def self.total_of_attribute collection, attribute
    collection.inject(0) {|total, e| total + e.send(attribute)}
  end
end
