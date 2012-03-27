class Entity < ActiveRecord::Base

  belongs_to :combat_log

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
  def npc?; not self.player; end

  # Public: Takes in parsed results and adds to the appropriate metrics
  def add_effect_result(skill, result)
    self.total_damage  ||= 0
    self.total_healing ||= 0

    if result[:effect].keys.include? :damage
      amount = result[:effect][:damage][:amount] 
      self.total_damage += amount
      self.max_damage = {skill: skill, amount: amount} if self.max_damage.empty? or amount > self.max_damage[:amount]
    end

    if result[:effect].keys.include? :heal
      amount = result[:effect][:heal][:amount] 
      self.total_healing += amount
      self.max_healing = {skill: skill, amount: amount} if self.max_healing.empty? or amount > self.max_healing[:amount]
    end

  end
end
