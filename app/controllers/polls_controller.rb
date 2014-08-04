class PollsController < ApplicationController
  before_action :set_poll, only: [:show, :edit, :update, :destroy]
  before_action :load_question

  # GET /polls
  # GET /polls.json
  def index
    @polls =  Question.find(params[:question_id]).poll
    # @location = location
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
  end

  # GET /polls/new
  def new
    @poll = Poll.new
  end

  # GET /polls/1/edit
  def edit
  end

  # POST /polls
  # POST /polls.json
  def create
    @location = location
    @answer = params[:answer]
    @poll = @question.poll.create(data: { answer: @answer, country_name: @location.first.data["country_name"], country_code: @location.first.data["country_code"], region_name: @location.first.data["region_name"], region_code: @location.first.data["region_code"], city: @location.first.data["city"] } )
    @question.add_to_data_table(@answer)
    
    respond_to do |format|
      if @poll.save
        format.html { redirect_to question_path(@question), notice: 'Vote entered.' }
        format.json { render :show, status: :created, poll: @poll.location.first }
      else
        format.html { render :new }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /polls/1
  # PATCH/PUT /polls/1.json
  def update
    respond_to do |format|
      if @poll.update(poll_params)
        format.html { redirect_to @poll, notice: 'Poll was successfully updated.' }
        format.json { render :show, status: :ok, location: @poll }
      else
        format.html { render :edit }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    @poll.destroy
    respond_to do |format|
      format.html { redirect_to polls_url, notice: 'Poll was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def location
    if params[:location].blank?
      if Rails.env.test? || Rails.env.development?
        @location ||= Geocoder.search("69.65.94.153")
      else
        @location ||= request.location
      end
    else
      params[:location].each { |l| l = l.to_i } if params[:location].is_a? Array
      @location ||= Geocoder.search(params[:location]).first
      @location
    end
  end

  def load_question
    @question = Question.find(params[:question_id])
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_poll
    @poll = @question.poll.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def poll_params
    params.require(:poll).permit(:answer, :location)
  end
end
