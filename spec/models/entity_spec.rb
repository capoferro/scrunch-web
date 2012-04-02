require 'spec_helper'

describe Entity do
  before do
    @encounter = Encounter.new
    @encounter.stub(:total_damage).and_return 1000
    @encounter.start_time = 5.minutes.ago
    @encounter.end_time  = 1.minute.ago
    @ahri = Entity.new(name: '@Ahri')
    @ahri.total_damage = 755
    @ahri.total_healing = 855
    @ahri.stub(:encounter).and_return @encounter
    @mob = Entity.new(name: 'Some Mob')
  end

  describe '#dps' do
    it 'should calculate damage per second' do
      @ahri.dps.should be_within(0.01).of(3.145)
    end
  end

  describe '#hps' do
    it 'should heals per second' do
      @ahri.hps.should be_within(0.01).of(3.562)
    end
  end

  describe '#type' do
    it 'should return player' do
      @ahri.type.should == :player
    end
    it 'should return mob' do
      @mob.type.should == :mob
    end
  end
  it 'should treat #npc? and #mob? the same for players' do
    @ahri.npc?.should == @ahri.mob?
  end


  it 'should treat #npc? and #mob? the same for mobs' do
    @mob.npc?.should == @mob.mob?
  end

  describe '#percent_' do
    describe 'damage' do
      it 'should calculate percentage of total damage done for an encounter' do
        mock_enc = mock(Encounter)
        mock_enc.stub(:total_damage).and_return 1000
        @ahri.stub(:encounter).and_return mock_enc
        @ahri.percent_damage.should == 75.5
      end
    end

    describe 'healing' do 
      it 'should calculate percentage of total healing done for an encounter' do
        mock_enc = mock(Encounter)
        mock_enc.stub(:total_healing).and_return 1000
        @ahri.stub(:encounter).and_return mock_enc

        @ahri.percent_healing.should == 85.5
      end     
    end
  end

  describe '::create' do
    describe 'should use the name *unknown* if the name is' do
      it 'not provided' do
        Entity.create.name.should == '*unknown*'
      end

      it 'nil' do
        Entity.create(name: nil).name.should == '*unknown*'
      end

      it 'empty' do
        Entity.create(name: '').name.should == '*unknown*'
      end
    end


    describe 'player character' do
      subject { Entity.create(name: '@Ahri') }

      it 'should recognize player character entries' do
        subject.player.should be_true
        subject.name.should == 'Ahri'
      end

      it '#player?' do
        subject.player?.should be_true
      end

      it '#npc?' do
        subject.npc?.should be_false
      end
    end
  end

  describe '#add_effect_result' do
    it 'should increment damage when a damage effect result is provided' do
      subject.add_effect_result 'adamage', type: 'ApplyEffect', detail: {concrete_type: 'Damage', amount: 4, type: 'energy'}
      subject.add_effect_result 'adamage', type: 'ApplyEffect', detail: {concrete_type: 'Damage', amount: 6, type: 'energy'}
      subject.total_damage.should == 10
      subject.max_damage.should == {skill: 'adamage', amount: 6}
    end
    it 'should increment healing when a heal effect result is provided' do
      subject.add_effect_result 'aheal', type: 'ApplyEffect', detail: {concrete_type: 'Heal', amount: 3, type: 'energy'}
      subject.add_effect_result 'aheal', type: 'ApplyEffect', detail: {concrete_type: 'Heal', amount: 7, type: 'energy'}
      subject.total_healing.should == 10
      subject.max_healing.should == {skill: 'aheal', amount: 7}
    end
  end
end
