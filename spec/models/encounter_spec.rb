require 'spec_helper'

describe Encounter do

  before do
    entities = (0..3).to_a.collect do |i|
      e = Entity.new(name: i)
      e.total_damage = 10
      e.total_healing = 5
      e.player = true if i == 0
      e
    end

    @encounter = Encounter.new
    @encounter.entities = entities

  end

  describe '#total_damage' do
    it 'should total up damage from all entities' do
      @encounter.total_damage.should == 40
    end
  end

  describe '#total_healing' do
    it 'should total up healing from all entities' do
      @encounter.total_healing.should == 20
    end
  end


  describe '#total_mob_damage' do
    it 'should ignore players when calculating total damage' do
      @encounter.total_mob_damage.should == 30
    end
  end

  describe '#total_mob_healing' do
    it 'should ignore players when calculating total healing' do
      @encounter.total_mob_healing.should == 15
    end
  end

  describe '#total_player_damage' do
    it 'should ignore mobs when calculating total damage' do
      @encounter.total_player_damage.should == 10
    end
  end

  describe '#total_player_healing' do
    it 'should ignore mobs when calculating total healing' do
      @encounter.total_player_healing.should == 5
    end
  end

  

end
