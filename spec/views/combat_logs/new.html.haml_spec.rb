require 'spec_helper'

describe "combat_logs/new" do
  before(:each) do
    assign(:combat_log, stub_model(CombatLog,
      :filename => "MyString"
    ).as_new_record)
  end

  it "renders new combat_log form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => combat_logs_path, :method => "post" do
      assert_select "input#combat_log_file", :name => "combat_log[filen]"
    end
  end
end
