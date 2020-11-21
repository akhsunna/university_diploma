class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project, only: :show

  def index
    @projects = current_user.projects
    @project = Project.new
  end

  def show
    case @project.status
    when 'questionnaire_in_progress'
      redirect_to project_parameter_path(@project)
    when 'questionnaire_finished'
      redirect_to start_project_parameters_comparisons_path(project_id: @project.id)
    when 'criteria_comparing_in_progress'
      redirect_to compare_project_parameters_comparisons_path(project_id: @project.id)
    when 'criteria_comparing_finished'
      redirect_to root_path # TODO: change
    when 'finished'
      redirect_to root_path # TODO: change
    end
  end

  def create
    @project = Project.new(project_params.merge(user: current_user))
    @project.save!

    redirect_to project_parameter_path(@project.id)
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end

  def find_project
    @project = Project.find(params[:id])
  end
end
