class PatientsController < ApplicationController
  before_filter :signed_in_physician
  before_filter :correct_physician,   except: [:search_ref, :new, :create, :index]

  # GET /patients
  # GET /patients.json
  def index
    @patients = Patient.search(params[:search], current_physician.id, params[:page])
                 
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @patients }
    end
  end

  def search_ref
      # local array
      patients = Patient.where('physician_id = ? AND reference_number = ?', 
          current_physician, params[:reference_number]).limit(1)
      if (patients.empty?)
        redirect_to patients_url, 
            alert: 'Reference ID ' + params[:reference_number] + ' not found'
      else
        @patient = patients[0]
        @visits = @patient.visits.paginate(per_page: 10, page: params[:page])
      end
     #defaults to render 'search_ref'
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
    @patient = Patient.find(params[:id])
    @visits = @patient.visits.paginate(per_page: 10, page: params[:page])
    #@visit = @patient.visits.build
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @patient }
    end
  end

  # GET /patients/new
  # GET /patients/new.json
  def new
    @patient = Patient.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @patient }
    end
  end

  # GET /patients/1/edit
  def edit
    @patient = Patient.find(params[:id])
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = current_physician.patients.build(params[:patient])

    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, notice: 'Patient was successfully created.' }
        format.json { render json: @patient, status: :created, location: @patient }
      else
        format.html { render action: "new" }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /patients/1
  # PUT /patients/1.json
  def update
    @patient = Patient.find(params[:id])

    respond_to do |format|
      if @patient.update_attributes(params[:patient])
        format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy

    respond_to do |format|
      format.html { redirect_to patients_url }
      format.json { head :no_content }
    end
  end



  def correct_physician
    @patient = current_physician.patients.find_by_id(params[:id])
    redirect_to root_path if @patient.nil?
  end

end
