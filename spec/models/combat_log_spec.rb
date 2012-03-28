require 'spec_helper'

describe CombatLog do
  subject { CombatLog.create file: File.new(logs_path.join('Ahri-vs-ForgeGuardian.txt')) }

  describe 'should alias paperclip methods to remove "file":' do
    it '#file_file_name' do
      subject.file_file_name.should == subject.file_name
    end

    it '#file_file_size' do
      subject.file_file_size.should == subject.file_size
    end
  end

  it '#crunch should parse the sources out of the combat log and create new source objects' do
    subject.crunch
    encs = subject.encounters
    encs.size.should == 1
    encs.each do |encounter|
      encounter.new_record?.should be_false
    end
    entity_names = encs.first.entities.collect(&:name)
    ['Ahri', 'Forge Guardian', 'Ahri:T7-O1'].each do |entity_name|
      entity_names.include?(entity_name).should be_true
    end
  end

end

describe CombatLog::Cruncher do

  describe '::crunch(@filename)' do
    it 'should crunch(@filename) logs and return a hash of damage sources with their damage output' do
      encounters = described_class.crunch(File.new(File.join logs_path, 'Ahri-vs-ForgeGuardian.txt'))
      enc = encounters.first
      
      enc.start_time.should == DateTime.parse('Sun, 18 Mar 2012 03:59:24 UTC +00:00')
      enc.end_time.should == DateTime.parse('Sun, 18 Mar 2012 04:00:37 UTC +00:00')

      (ahri = enc.entities.select { |e| e.name == '@Ahri' }.first).total_damage.should == 2825
      enc.entities.select { |e| e.name == '@Ahri:T7-O1' }.first.total_damage.should == 859
      enc.entities.select { |e| e.name == 'Forge Guardian'}.first.total_damage.should == 3122
      ahri.total_healing.should == 392
      ahri.max_healing.should == {skill: 'Minor Medpac', amount: 392}
      ahri.max_damage.should == {skill: 'Slash', amount: 193}
    end

    it 'should not explode when reading a file with an invalid byte sequence' do
      -> { described_class.crunch File.new(File.join(logs_path, 'Ahri-PvP.txt'))  }.should_not raise_error
    end
  end
  describe '::parse' do
    describe 'a combat start line' do
      before { @enter_combat_line = "[03/18/2012 03:59:24] [@Ahri] [@Ahri] [] [Event {836045448945472}: EnterCombat {836045448945489}] ()" }
      
      it 'should recognize combat start' do
        described_class.parse(@enter_combat_line).should == ['03/18/2012 03:59:24', '@Ahri', nil, 'Event {836045448945472}: EnterCombat {836045448945489}] ()']
      end

    end

    describe 'a combat end line' do
    end

    describe 'a damage line' do
      before do
        @damage_line = '[03/18/2012 03:59:24] [@Ahri] [Forge Guardian {795067165966336}] [Force Leap {812105301229568}] [ApplyEffect {836045448945477}: Damage {836045448945501}] (73 energy {836045448940874}) <73>'
      end

      it 'should take a line and parse it into source and effect result' do
        described_class.parse(@damage_line).should == ["03/18/2012 03:59:24", "@Ahri", "Force Leap", "ApplyEffect {836045448945477}: Damage {836045448945501}] (73 energy {836045448940874}) <73>"]
      end
    end
    describe 'a non-damage line' do
      ['[03/18/2012 03:55:59] [@Ahri] [@Ahri] [Basic Might Stim {813333661876224}] [ApplyEffect {836045448945477}: Basic Might Stim {813333661876224}] ()', '[03/18/2012 03:56:05] [@Ahri] [@Ahri] [Safe Login {973870949466112}] [RemoveEffect {836045448945478}: Safe Login Immunity {973870949466372}] ()'].each do |line|
        it "#{line} should not explode" do
          -> {described_class.parse line}.should_not raise_error
        end
      end
    end
  end
  describe '::parse_effect_result' do
    it 'should disregard bugged ApplyEffect results' do
      described_class.parse_effect_result("ApplyEffect {836045448945477}:  {2775472291184640}] ()\r\n").should == {type: 'ApplyEffect', detail: {concrete_type: ''}}
    end

    describe 'modifier result' do
      before {@result = "ApplyEffect {836045448945477}: Accuracy Reduced [Tech] {2848396540903685}] ()\r\n"}

      it 'should not explode' do
        -> {described_class.parse_effect_result @result}.should_not raise_error
      end
    end
    
    describe "damage result" do
    before do
      @result = 'ApplyEffect {836045448945477}: Damage {836045448945501}] (73 energy {836045448940874}) <73>'
    end

    it 'should return a hash of the details of the result chunk' do
      described_class.parse_effect_result(@result).should == {type: 'ApplyEffect', detail: {concrete_type: 'Damage', amount: 73, type: 'energy'}}
    end
    end
    describe "enter combat" do
      before {@result = 'Event {836045448945472}: EnterCombat {836045448945489}] ()'}
      it 'should recognize enter combat events' do
        described_class.parse_effect_result(@result).should == {type: 'Event', detail: {concrete_type: 'EnterCombat'}}
      end
    end
    describe 'exit combat' do
      before {@result = 'Event {836045448945472}: ExitCombat {836045448945490}] ()'}
      it 'should recognize exit combat events' do
        described_class.parse_effect_result(@result).should == {type: 'Event', detail: {concrete_type: 'ExitCombat'}}
      end
    end
  end

end

