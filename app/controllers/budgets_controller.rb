class BudgetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_budget, only: %i[ show edit update destroy cancel confirm ]
  before_action :authenticate_admin, only: %i[ cancel confirm ]

  # GET /budgets or /budgets.json
  def index
    if current_user.admin?
      @budgets = Budget.all
    else
      @budgets = current_user.budgets
    end
    
    respond_to do |format|
      format.html
      format.json { render json: @budgets, status: :ok }
    end
  end

  # GET /budgets/1 or /budgets/1.json
  def show
  end

  # GET /budgets/new
  def new
    @budget = Budget.new
  end

  # GET /budgets/1/edit
  def edit
  end

  # POST /budgets or /budgets.json
  def create
    @budget = current_user.budgets.new(budget_params)

    @budget.end_time = @budget.start_time + 2.hours

    respond_to do |format|
      if @budget.save   
        CreateEventGoogleCalendarWorker.perform_async(@budget.id)

        format.html { redirect_to budget_url(@budget), notice: "Budget was successfully created." }
        format.json { render :show, status: :created, location: @budget }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /budgets/1 or /budgets/1.json
  def update
    respond_to do |format|
      if @budget.update(budget_params)
        format.html { redirect_to budget_url(@budget), notice: "Budget was successfully updated." }
        format.json { render :show, status: :ok, location: @budget }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budgets/1 or /budgets/1.json
  def destroy
    @budget.destroy

    respond_to do |format|
      format.html { redirect_to budgets_url, notice: "Budget was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def cancel
    if @budget.update(status: 'CANCELADO', canceled: true) 
      DeleteEventCalendar.new.delete_event(@budget.id)

      respond_to do |format|
        format.html { redirect_to budget_url(@budget), notice: "Budget was successfully canceled." }
        format.json { head :no_content }
      end
    else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @budget.errors, status: :unprocessable_entity }
    end
  end

  def confirm
    if @budget.update(status: 'CONFIRMADO', canceled: false)
      UpdateEventCalendar.new.update_event(@budget.id)

      respond_to do |format|
        format.html { redirect_to budget_url(@budget), notice: "Budget was successfully confirmed." }
        format.json { head :no_content }
      end
    else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @budget.errors, status: :unprocessable_entity }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_budget
      if current_user.admin?
        @budget = Budget.find(params[:id])
      else
        @budget = current_user.budgets.find(params[:id])
      end
    end

    # Only allow a list of trusted parameters through.
    def budget_params
      params.require(:budget).permit(:event_date, :guest_count, :status, :canceled, :start_time, :end_time, :cake_flavor, :main_course, :profit, :revenue, :expense, :suggestion, :google_event_id, :event_type_id, :decoration_id)
    end
end
