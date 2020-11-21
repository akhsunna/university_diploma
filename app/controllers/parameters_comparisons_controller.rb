class ParametersComparisonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_comparison, only: %i[confirm]

  def compare
    if @project.questionnaire_finished?
      Comparison::CreateRecords.new.call(@project)
      @project.criteria_comparing_in_progress!
    end

    @comparison = @project.next_for_compare

    unless @comparison
      @project.criteria_comparing_finished!
      redirect_to project_path(@project.id)
    end
  end

  def skip
    @project.parameters_comparisons.destroy_all
    redirect_to project_path(@project.id)
  end

  def confirm
    @comparison.update!(comparison_params.merge(status: :confirmed))
    # TODO: set value for inversed
    @project.criteria_comparing_in_progress!
    redirect_to compare_project_parameters_comparisons_path(project_id: params[:project_id])
  end

  def start
  end

  private

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end

  def set_comparison
    @comparison = ParametersComparison.find(params[:id])
  end

  def comparison_params
    params.permit(:simplified_value)
  end
end
