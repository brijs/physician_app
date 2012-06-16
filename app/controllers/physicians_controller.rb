class PhysiciansController < ApplicationController
  before_filter :signed_in_physician, except: [:new, :create, :index]
  before_filter :correct_physician, except: [:new, :create, :index]
  before_filter :admin_physician, only: [:index]
  #before_filter :admin_physician, only: [:index]

  # GET /physicians
  # GET /physicians.json
  def index
    @physicians = Physician.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @physicians }
    end
  end

  # GET /physicians/1
  # GET /physicians/1.json
  def show
    @physician = Physician.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @physician }
    end
  end

  # GET /physicians/new
  # GET /physicians/new.json
  def new
    @physician = Physician.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @physician }
    end
  end

  # GET /physicians/1/edit
  def edit
    @physician = Physician.find(params[:id])
  end

  # POST /physicians
  # POST /physicians.json
  def create
    @physician = Physician.new(params[:physician])

    if @physician.save
        sign_in @physician
        flash[:success] = "Welcome to Brij's online patient management dashboard"
        redirect_to static_pages_home_path
    else
        render :new
    end
    
  end

  # PUT /physicians/1
  # PUT /physicians/1.json
  def update
    @physician = Physician.find(params[:id])

    respond_to do |format|
      if @physician.update_attributes(params[:physician])
        format.html { redirect_to @physician, notice: 'Physician was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @physician.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /physicians/1
  # DELETE /physicians/1.json
  def destroy
    @physician = Physician.find(params[:id])
    @physician.destroy

    respond_to do |format|
      format.html { redirect_to physicians_url }
      format.json { head :no_content }
    end
  end

private
  def correct_physician
    physician = Physician.find_by_id(params[:id])
    if !(current_physician.id == physician.id || current_physician.admin?)
      redirect_to root_path
    end   
  end

  def admin_physician
    if current_physician.nil? || !current_physician.admin?
      redirect_to root_path 
    end
  end


end
