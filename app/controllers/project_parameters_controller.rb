class ProjectParametersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project_parameter_value, only: %i[update skip]
  before_action :find_project

  def show
    @project_parameter_value = @project.next_for_value
    @parameter = @project_parameter_value.parameter
  end

  def update
    @project_parameter_value.update(value_params.merge(status: :confirmed))
    redirect_after_save
  end

  def skip
    @project_parameter_value.skipped!
    redirect_after_save
  end

  private

  def find_project
    @project = @project_parameter_value&.project || Project.find(params[:id])
  end

  def find_project_parameter_value
    @project_parameter_value = ProjectParameterValue.find(params[:id])
  end

  def value_params
    params.require(:project_parameter_value).permit(:parameter_value_id)
  end

  def redirect_after_save
    if @project.parameter_values.not_set.blank?
      @project.questionnaire_finished!
      redirect_to start_project_parameters_comparisons_path(project_id: @project.id)
    else
      @project.questionnaire_in_progress!
      redirect_to project_parameter_path(@project)
    end
  end
end
