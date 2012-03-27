require 'spec_helper'

describe Entity do
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
      subject.add_effect_result effect: {damage: {amount: 5, type: 'energy'}}
      subject.add_effect_result effect: {damage: {amount: 5, type: 'energy'}}
      subject.total_damage.should == 10
    end
    it 'should increment healing when a heal effect result is provided' do
      subject.add_effect_result effect: {heal: {amount: 5, type: 'energy'}}
      subject.add_effect_result effect: {heal: {amount: 5, type: 'energy'}}
      subject.total_healing.should == 10
    end
  end
end
