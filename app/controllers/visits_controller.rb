class VisitsController < ApplicationController
  before_filter :signed_in_physician
  before_filter :correct_physician, :except => [:index]
  
  # GET /visits
  # GET /visits.json
  def index
    @visits = VisitSearch.new.visits current_physician, params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @visits }
    end
  end

  # GET /patients/:patient_id/patients/:patient_id/visits/1
  # GET /patients/:patient_id/visits/1.json
  def show
    @visit = Visit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @visit }
      format.pdf do
        visitPdf = Prawn::Document.new
        
        pdf_header1 visitPdf
        pdf_header2 visitPdf
        pdf_body visitPdf
        pdf_footer visitPdf
        
        send_data visitPdf.render, type: "application/pdf", disposition: "inline"
        # send_data renders the pdf on the client side rather than saving it on the server filesystem.
        # Inline disposition renders it in the browser rather than making it a file download.
      end
    end
  end

  # GET /patients/:patient_id/patients/:patient_id/visits/new
  # GET /patients/:patient_id/visits/new.json
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

  # POST /patients/:patient_id/visits
  # POST /patients/:patient_id/visits.json
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

  # PUT /patients/:patient_id/visits/1
  # PUT /patients/:patient_id/visits/1.json
  def update
    @visit = Visit.find(params[:id])

    respond_to do |format|
      if @visit.update_attributes(params[:visit])
        format.html { redirect_to patient_path(params[:patient_id]), notice: 'Visit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/:patient_id/patients/:patient_idvisits/1
  # DELETE /patients/:patient_id/visits/1.json
  def destroy
    @visit = Visit.find(params[:id])
    @visit.destroy

    respond_to do |format|
      format.html { redirect_to patient_path (params[:patient_id]) }
      format.json { head :no_content }
    end
  end

  
  private

  #todo: these need to be moved to separate modules
  def pdf_header1 pdf
    pdf.formatted_text_box(
      [
        {:text => "Dr. Gaurish M. Shetty\n", 
          :color => "FF0000", :styles => [:bold], :size => 15,
          :font => "Times-Roman"},
        {:text => "Consultant Physician"},
        {:text => "      M.B.B.S, M.D\n", :align => :right},
        {:text => "Reg No. 70537"}
      ],
      :at => [pdf.bounds.left ,pdf.bounds.top], :width => 250, :height => 70);

    pdf.formatted_text_box(
      [
        {:text => "Asst. Prof. of General Medicine\n"},
        {:text => "A.J. Shetty Medical Hospital,\n"},
        {:text => "Kuntikana, MANGALORE - 4.\n"}
      ],
      :at => [325,pdf.bounds.top], :width => 250, :height => 70);

    pdf.move_down 55
    pdf.stroke_horizontal_rule
    pdf.move_down 10
  end

  def pdf_header2 pdf
    pdf.formatted_text_box(
      [
        {:text => "CLINIC", :color => "FF0000"},
        {:text => ": MEDICAL CHAMBERS,\n"},
        {:text => "Don Bosco Hall Cross Road,\n"},
        {:text => "Balmatta, MANGALORE - 1\n"},
        {:text => "Monday to Friday 1.00 pm to 1.45 pm\n"},
        {:text => "#{Prawn::Text::NBSP * 29}4.30 pm to 7.30 pm\n"},
        {:text => "#{Prawn::Text::NBSP * 14}Saturday 3.00 pm to 7.00 pm\n"},
      ],
      :at => [pdf.bounds.left, pdf.cursor], :width => 250, :height => 90);

    pdf.formatted_text_box(
      [
        {:text => "TEJASWINI HOSPITAL\n"},
        {:text => "Kadri\n"},
        {:text => "Mangalore\n"},
        {:text => "Monday to Friday 2.00 pm to 2.30 pm\n"},
        {:text => "#{Prawn::Text::NBSP * 29}7.30 pm to 8.30 pm\n"},
        {:text => "#{Prawn::Text::NBSP * 14}Saturday 2.00 pm to 3.00 pm\n"},
      ],
      :at => [325, pdf.cursor], :width => 250, :height => 90);

    pdf.move_down 95
    pdf.stroke_horizontal_rule 
    pdf.move_down 10
  end

  def pdf_footer pdf
    pdf.move_cursor_to 70
    pdf.stroke_horizontal_rule 
    
    pdf.formatted_text_box(
      [
        {:text => "FOR APPOINTMENT\n", :color => "FF0000", :styles => [:bold]},
        {:text => "MEDICAL CHAMBERS - Call: 0824 - 2427644, 0824 - 2428669 Mobile: 99004070027\n"},
        {:text => "TEJASWINI HOSPITAL - Call: 0824 - 2880100\n"},
        {:text => "email: gaurishetty20@gmail.com"}
      ],
      :at => [pdf.bounds.left, pdf.bounds.bottom + 65], 
      :width  => pdf.bounds.width, :align => :center);
  end

  def pdf_body pdf
    pdf.move_down 10
    pdf.formatted_text_box(
      [
        {:text => @visit.date_of_visit.strftime("%b %d %Y"), :styles => [:italic]}
      ],
    :at => [350, pdf.cursor], :align => :right)
    pdf.text display_name_for(@visit.patient), :style => :bold

    pdf.text "\n\nComplaints:"
    pdf.text @visit.complaints unless @visit.complaints.blank?
    pdf.text "\n\nFindings:"
    pdf.text @visit.complaints unless @visit.findings.blank?
    pdf.text "\n\nTreatment:"
    pdf.text @visit.complaints unless @visit.treatment.blank?
    pdf.text "\n\nDiagnosis:"
    pdf.text @visit.complaints unless @visit.diagnosis.blank?
    pdf.text "\n\nNotes:"
    pdf.text @visit.complaints unless @visit.notes.blank?
  end


  # todo: move to shared module; cant call helpers from controllers
  def display_name_for(user)
    user.first_name.capitalize + ' ' + user.last_name.capitalize + ' ( ID: ' + user.reference_number + ')'
  end

  def correct_physician
    @patient = current_physician.patients.find_by_id(params[:patient_id])
    if @patient.nil?
      redirect_to patients_path, :alert => "Not authorized"
    elsif (params[:id]) #verify visit.patient_id
      @visit = Visit.find_by_id(params[:id])
      if @visit.nil?
        # double redirection suppresses the alert
        redirect_to patients_path, :alert => "Not authorized"
      else
        @patient = current_physician.patients.find_by_id(@visit.patient_id)
        redirect_to patients_path, :alert => "Not authorized" if @patient.nil?
      end
    end
    
  end

end
