class Encounter < ActiveRecord::Base

  belongs_to :combat_log
  has_many :entities
  has_one :owner, class_name: 'Entity'

  def duration_in_seconds
    duration.to_i
  end

  def duration
    self.end_time - self.start_time
  end

  def player_entities
    entities.select(&:player?)
  end

  def mob_entities
    entities.select(&:mob?)
  end

  def total_damage type=nil
    ents = if type.nil?
             self.entities
           else
             entities.select { |e| e.type == type }
           end
    self.class.total_of_attribute ents, :total_damage
  end

  def total_healing type=nil
    ents = if type.nil?
             self.entities
           else
             entities.select { |e| e.type == type }
           end
    self.class.total_of_attribute ents, :total_healing
  end

  def self.total_of_attribute collection, attribute
    collection.inject(0) {|total, e| total + e.send(attribute)}
  end
end
