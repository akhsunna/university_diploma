class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project, only: %i[show result export]

  def index
    @projects = current_user.projects.order(id: :desc)
    @project = Project.new
  end

  def show
    case @project.status
    when 'questionnaire_in_progress', 'created'
      redirect_to project_parameter_path(@project)
    when 'questionnaire_finished'
      redirect_to start_project_parameters_comparisons_path(project_id: @project.id)
    when 'criteria_comparing_in_progress'
      redirect_to compare_project_parameters_comparisons_path(project_id: @project.id)
    when 'criteria_comparing_finished'
      redirect_to root_path # TODO: change
    when 'finished'
      redirect_to result_project_path(@project.id)
    end
  end

  def create
    @project = Project.new(project_params.merge(user: current_user))
    @project.save!

    redirect_to project_parameter_path(@project.id)
  end

  def result
    @ms = @project.methodology_scores.ordered
    @best_ms = @project.methodology_scores.ordered.first
    @current_ms = @project.methodology_scores.find_by(id: params[:methodology_score_id]) || @best_ms

    render :show
  end

  def export
    if @project.finished?

      @methodology_scores = @project.methodology_scores.ordered

      respond_to do |format|
        format.xlsx { render xlsx: 'export', filename: "Results for #{@project.name}.xlsx" }
      end
    else
      head :bad_request
    end
  end

  def export_all

  end

  private

  def project_params
    params.require(:project).permit(:name)
  end

  def find_project
    @project = Project.find(params[:id])
  end
end
