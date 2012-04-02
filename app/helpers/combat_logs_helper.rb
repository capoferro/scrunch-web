module CombatLogsHelper

  def sorted_by_total_and_type tally, entities
    entities
      .sort_by(&tally)
      .sort { |a,b|
      if a.mob? and b.player?
        -1
      elsif a.player? and b.mob?
        1
      else
        0
      end
    }.reverse
  end

end
