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
    @encounter.start_time = 5.minutes.ago
    @encounter.end_time = 1.minute.ago
    @encounter.entities = entities
  end

  describe '#duration_in_seconds' do
    it 'should calculate the number of seconds the encounter took' do
      @encounter.duration_in_seconds.should be_within(0.001).of 240
    end
  end

  describe '#duration' do
    it 'should return the duration of the encounter' do
      @encounter.duration.should be_within(0.001).of 4.minutes
    end
  end

  describe '#player_entities' do
    it 'should return a list of player entities only' do
      @encounter.player_entities.size.should == 1
    end
  end

  describe '#mob_entities' do
    it 'should return a list of mob entities only' do
      @encounter.mob_entities.size.should == 3
    end
    it 'should not return *unknown*' do
      @encounter.entities << Entity.new(name: '*unknown*')
      
      @encounter.mob_entities.size.should == 3
    end
  end

  describe '#total_damage' do
    it 'should total up damage from all entities' do
      @encounter.total_damage.should == 40
    end
    it 'should ignore players when calculating total damage' do
      @encounter.total_damage(:mob).should == 30
    end
    it 'should ignore mobs when calculating total damage' do
      @encounter.total_damage(:player).should == 10
    end
  end 
  describe '#total_healing' do
    it 'should total up healing from all entities' do
      @encounter.total_healing.should == 20
    end

    it 'should ignore mobs when calculating total healing' do
      @encounter.total_healing(:player).should == 5
    end
    
    it 'should ignore players when calculating total healing' do
      @encounter.total_healing(:mob).should == 15
    end
  end
end
