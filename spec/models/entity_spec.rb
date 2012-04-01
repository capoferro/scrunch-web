require 'spec_helper'

describe Entity do
  it 'should treat #npc? and #mob? the same' do
    e = Entity.new(name: '@Ahri')
    e.npc?.should == e.mob?
  end

  describe '#percent_' do
    describe 'damage' do
      it 'should calculate percentage of total damage done for an encounter' do
        mock_enc = mock(Encounter)
        mock_enc.stub(:total_damage).and_return 1000
        e = Entity.create
        e.stub(:encounter).and_return mock_enc
        e.stub(:total_damage).and_return 755

        e.percent_damage.should == 75.5
      end
    end

    describe 'healing' do 
      it 'should calculate percentage of total healing done for an encounter' do
        mock_enc = mock(Encounter)
        mock_enc.stub(:total_healing).and_return 1000
        e = Entity.create
        e.stub(:encounter).and_return mock_enc
        e.stub(:total_healing).and_return 755

        e.percent_healing.should == 75.5
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
