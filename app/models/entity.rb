class Entity < ActiveRecord::Base

  belongs_to :encounter

  before_create :catch_blank_entity, :specify_player_or_npc

  serialize :max_damage, Hash
  serialize :max_healing, Hash

  (UNKNOWN_NAME = '*unknown*').freeze

  def catch_blank_entity
    self.name = UNKNOWN_NAME if self.name.blank?
  end

  def specify_player_or_npc
    self.player = if self.name[0] == '@'
                    self.name.gsub! /@/, ''
                    true
                  else
                    false
                  end
    true # don't interrupt creation
  end

  def player?
    specify_player_or_npc if self.player.nil?
    self.player
  end

  def mob?
    !(self.player? or self.name == UNKNOWN_NAME)
  end
  alias :npc? :mob?
  
  def type
    self.player? ? :player : :mob
  end

  # Public: Takes in parsed results and adds to the appropriate metrics
  #
  # Returns nothing
  def add_effect_result(skill, result)
    self.total_damage  ||= 0
    self.total_healing ||= 0

    case result[:detail][:concrete_type]
    when 'Damage'
      amount = result[:detail][:amount] 
      self.total_damage += amount
      self.max_damage = {skill: skill, amount: amount} if self.max_damage.empty? or amount > self.max_damage[:amount]
    when 'Heal'
      amount = result[:detail][:amount] 
      self.total_healing += amount
      self.max_healing = {skill: skill, amount: amount} if self.max_healing.empty? or amount > self.max_healing[:amount]
    end
  end

  # Public: Calculates the amount of damage done relative to the total damage done in an encounter
  #
  # compared_to_type - :player or :mob
  #
  # Returns Float
  def percent_damage(compared_to_type=nil)
    self.class.percent_of self.total_damage, self.encounter.total_damage(compared_to_type)
  end

  def percent_healing(compared_to_type=nil)
    self.class.percent_of self.total_healing, self.encounter.total_healing(compared_to_type)
  end

  def self.percent_of a, b
    return 0 if b == 0
    100 * a.to_f / b.to_f
  end

  # Public: calculates damage per second
  #
  # Retuns float
  def dps
    self.total_damage.to_f / self.encounter.duration_in_seconds
  end

  #Public: calculates healing per second
  #
  # Returns flaot
  def hps
    self.total_healing.to_f / self.encounter.duration_in_seconds
  end
end
