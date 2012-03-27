class Entity < ActiveRecord::Base

  belongs_to :combat_log

  before_create :catch_blank_entity, :specify_player_or_npc

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
  def add_effect_result(result)
    self.total_damage ||= 0
    self.total_healing ||= 0
    self.total_damage += result[:effect][:damage][:amount] if result[:effect].keys.include? :damage
    self.total_healing += result[:effect][:heal][:amount] if result[:effect].keys.include? :heal
  end
end
