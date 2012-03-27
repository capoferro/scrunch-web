class Entity < ActiveRecord::Base

  belongs_to :combat_log

  before_create :catch_blank_entity, :specify_player_or_npc

  after_initialize :initialize_tracking_values

  (UNKNOWN_NAME = '*unknown*').freeze

  def initialize_tracking_values
    self.total_damage = 
      self.total_healing = 
      self.max_damage = 
      self.max_healing = 0
  end

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
  def npc?; not self.player; end

  # Public: Takes in parsed results and adds to the appropriate metrics
  def add_effect_result(result)
    if result[:effect].keys.include? :damage
      amount = result[:effect][:damage][:amount] 
      self.total_damage += amount
      self.max_damage = amount if amount > self.max_damage
    end

    if result[:effect].keys.include? :heal
      amount = result[:effect][:heal][:amount] 
      self.total_healing += amount
      self.max_healing = amount if amount > self.max_healing
    end

  end
end
