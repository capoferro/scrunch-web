class CombatLogsController < ApplicationController
  def index
    @combat_logs = CombatLog.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @combat_logs }
    end
  end

  def show
    @combat_log = CombatLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @combat_log }
    end
  end

  def new
    @combat_log = CombatLog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @combat_log }
    end
  end

  def create
    @combat_log = CombatLog.new(params[:combat_log])

    respond_to do |format|
      if @combat_log.save
        # Can't crunch in after_create cause the file hasn't been
        # moved to the paperclip dir by then and will ENOENT
        @combat_log.crunch
        format.html { redirect_to @combat_log, notice: 'Combat log was successfully created.' }
        format.json { render json: @combat_log, status: :created, location: @combat_log }
      else
        format.html { render action: "new" }
        format.json { render json: @combat_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @combat_log = CombatLog.find(params[:id])
    @combat_log.destroy

    respond_to do |format|
      format.html { redirect_to combat_logs_url }
      format.json { head :no_content }
    end
  end
end
