require 'spec_helper'
require 'tempfile'

describe CombatLogsController do

  def valid_attributes
    {file: Tempfile.new('combat_log.txt')}
  end
  
  def valid_post
    {combat_log: valid_attributes}
  end

  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all combat_logs as @combat_logs" do
      combat_log = CombatLog.create! valid_attributes
      get :index, {}, valid_session
      assigns(:combat_logs).should eq([combat_log])
    end
  end

  describe "GET show" do
    it "assigns the requested combat_log as @combat_log" do
      combat_log = CombatLog.create! valid_attributes
      get :show, {:id => combat_log.to_param}, valid_session
      assigns(:combat_log).should eq(combat_log)
    end
  end

  describe "GET new" do
    it "assigns a new combat_log as @combat_log" do
      get :new, {}, valid_session
      assigns(:combat_log).should be_a_new(CombatLog)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new CombatLog" do
        expect {
          post :create, valid_post, valid_session
        }.to change(CombatLog, :count).by(1)
      end

      it "assigns a newly created combat_log as @combat_log" do
        post :create, valid_post, valid_session
        assigns(:combat_log).should be_a(CombatLog)
        assigns(:combat_log).should be_persisted
      end

      it "redirects to the created combat_log" do
        post :create, valid_post, valid_session
        response.should redirect_to(CombatLog.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved combat_log as @combat_log" do
        # Trigger the behavior that occurs when invalid params are submitted
        CombatLog.any_instance.stub(:save).and_return(false)
        post :create, {:combat_log => {}}, valid_session
        assigns(:combat_log).should be_a_new(CombatLog)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        CombatLog.any_instance.stub(:save).and_return(false)
        post :create, {:combat_log => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested combat_log" do
      combat_log = CombatLog.create! valid_attributes
      expect {
        delete :destroy, {:id => combat_log.to_param}, valid_session
      }.to change(CombatLog, :count).by(-1)
    end

    it "redirects to the combat_logs list" do
      combat_log = CombatLog.create! valid_attributes
      delete :destroy, {:id => combat_log.to_param}, valid_session
      response.should redirect_to(combat_logs_url)
    end
  end

end
