class DestroysController < ApplicationController
  # GET /destroys
  # GET /destroys.json
  def index
    @destroys = Destroy.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @destroys }
    end
  end

  # GET /destroys/1
  # GET /destroys/1.json
  def show
    @destroy = Destroy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @destroy }
    end
  end

  # GET /destroys/new
  # GET /destroys/new.json
  def new
    @destroy = Destroy.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @destroy }
    end
  end

  # GET /destroys/1/edit
  def edit
    @destroy = Destroy.find(params[:id])
  end

  # POST /destroys
  # POST /destroys.json
  def create
    @destroy = Destroy.new(params[:destroy])

    respond_to do |format|
      if @destroy.save
        format.html { redirect_to @destroy, notice: 'Destroy was successfully created.' }
        format.json { render json: @destroy, status: :created, location: @destroy }
      else
        format.html { render action: "new" }
        format.json { render json: @destroy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /destroys/1
  # PUT /destroys/1.json
  def update
    @destroy = Destroy.find(params[:id])

    respond_to do |format|
      if @destroy.update_attributes(params[:destroy])
        format.html { redirect_to @destroy, notice: 'Destroy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @destroy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /destroys/1
  # DELETE /destroys/1.json
  def destroy
    @destroy = Destroy.find(params[:id])
    @destroy.destroy

    respond_to do |format|
      format.html { redirect_to destroys_url }
      format.json { head :no_content }
    end
  end
end
