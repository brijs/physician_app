class VisitsController < ApplicationController
  before_filter :signed_in_physician
  
  # GET /visits
  # GET /visits.json
  def index
    @visits = VisitSearch.new.visits current_physician, params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @visits }
    end
  end

  # GET /visits/1
  # GET /visits/1.json
  def show
    @visit = Visit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @visit }
    end
  end

  # GET /visits/new
  # GET /visits/new.json
  def new
    @patient = Patient.find(params[:patient_id])
    @visit = Visit.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @visit }
    end
  end

  # GET /patients/1/visits/1/edit
  def edit
    @patient = Patient.find(params[:patient_id])
    @visit = Visit.find(params[:id])
  end

  # POST patients/1/visits
  # POST /visits.json
  def create
    @patient = Patient.find(params[:patient_id])
    @visit = @patient.visits.build(params[:visit])

    respond_to do |format|
      if @visit.save
        format.html { redirect_to @patient, notice: 'Visit was successfully created.' }
        format.json { render json: @visit, status: :created, location: @visit }
      else
        format.html { render action: "new" }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /visits/1
  # PUT /visits/1.json
  def update
    @visit = Visit.find(params[:id])

    respond_to do |format|
      if @visit.update_attributes(params[:visit])
        format.html { redirect_to @visit, notice: 'Visit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visits/1
  # DELETE /visits/1.json
  def destroy
    @visit = Visit.find(params[:id])
    @visit.destroy

    respond_to do |format|
      format.html { redirect_to visits_url }
      format.json { head :no_content }
    end
  end
end
