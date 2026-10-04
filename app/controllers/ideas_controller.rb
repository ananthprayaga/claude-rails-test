class IdeasController < ApplicationController
  before_action :set_idea, only: %i[ show edit update destroy toggle_star ]

  # GET /ideas
  def index
    @ideas = Idea.search(params[:q])
                 .with_status(params[:status])
                 .in_category(params[:category])
                 .sorted_by(params[:sort])
    @ideas = @ideas.starred if params[:starred] == "1"

    @status_counts = Idea.group(:status).count
    @total_count = Idea.count
    @categories = Idea.categories
  end

  # GET /ideas/1
  def show
  end

  # GET /ideas/new
  def new
    @idea = Idea.new
  end

  # GET /ideas/1/edit
  def edit
  end

  # POST /ideas
  def create
    @idea = Idea.new(idea_params)

    if @idea.save
      redirect_to root_path, notice: "Idea saved."
    else
      render :new, status: :unprocessable_content
    end
  end

  # PATCH/PUT /ideas/1
  def update
    if @idea.update(idea_params)
      redirect_to root_path, notice: "Idea updated.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  # PATCH /ideas/1/toggle_star
  def toggle_star
    @idea.update!(starred: !@idea.starred)
    redirect_back_or_to @idea, status: :see_other
  end

  # DELETE /ideas/1
  def destroy
    @idea.destroy!
    redirect_to ideas_path, notice: "Idea deleted.", status: :see_other
  end

  private
    def set_idea
      @idea = Idea.find(params.expect(:id))
    end

    def idea_params
      params.expect(idea: [ :title, :description, :category, :status, :potential, :target_market, :revenue_model, :notes, :starred ])
    end
end
