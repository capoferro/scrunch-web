require 'spec_helper'

describe "combat_logs/index" do
  before(:each) do
    assign(:combat_logs, [
      stub_model(CombatLog,
        :filename => "Filename"
      ),
      stub_model(CombatLog,
        :filename => "Filename"
      )
    ])
  end

  it "renders a list of combat_logs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Filename".to_s, :count => 2
  end
end
