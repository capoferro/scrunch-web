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
    self.player = if self.name[0] =~ /@/
                    self.name.gsub! /@/, ''
                    true
                  else
                    false
                  end
    true # don't interrupt creation
  end

  def player?; self.player; end
  def mob?; not self.player; end
  alias :npc? :mob?

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
  # Returns Float
  def percent_damage
    self.class.percent_of self.total_damage, self.encounter.total_damage
  end

  def percent_healing
    self.class.percent_of self.total_healing, self.encounter.total_healing
  end

  def self.percent_of a, b
    100 * a.to_f / b.to_f
  end
end
