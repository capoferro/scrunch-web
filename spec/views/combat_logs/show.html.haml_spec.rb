require 'spec_helper'

describe "combat_logs/show" do
  before(:each) do
    @combat_log = assign(:combat_log, stub_model(CombatLog,
      :filename => "Filename"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Filename/)
  end
end
