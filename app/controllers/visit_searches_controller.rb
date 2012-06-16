class VisitSearchesController < ApplicationController
  # GET /visit_searches
  # GET /visit_searches.json
  def index
    @visit_searches = VisitSearch.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @visit_searches }
    end
  end

  # GET /visit_searches/1
  # GET /visit_searches/1.json
  def show
    @visit_search = VisitSearch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @visit_search }
    end
  end

  # GET /visit_searches/new
  # GET /visit_searches/new.json
  def new
    @visit_search = VisitSearch.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @visit_search }
    end
  end

  # GET /visit_searches/1/edit
  def edit
    @visit_search = VisitSearch.find(params[:id])
  end

  # POST /visit_searches
  # POST /visit_searches.json
  def create
    physician = current_physician
    @visit_search = VisitSearch.new(params[:visit_search])
    @visits = @visit_search.visits(physician, params[:page]);
    render 'visits/index'
  end


  # PUT /visit_searches/1
  # PUT /visit_searches/1.json
  def update
    @visit_search = VisitSearch.find(params[:id])

    respond_to do |format|
      if @visit_search.update_attributes(params[:visit_search])
        format.html { redirect_to @visit_search, notice: 'Visit search was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @visit_search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visit_searches/1
  # DELETE /visit_searches/1.json
  def destroy
    @visit_search = VisitSearch.find(params[:id])
    @visit_search.destroy

    respond_to do |format|
      format.html { redirect_to visit_searches_url }
      format.json { head :no_content }
    end
  end
end
