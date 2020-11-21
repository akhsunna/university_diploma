class ParametersComparisonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_comparison, only: %i[confirm]

  def compare
    if @project.questionnaire_finished?
      Ahp::CreateRecords.new.call(@project)
      @project.criteria_comparing_in_progress!
    end

    @comparison = @project.next_for_compare

    unless @comparison
      Ahp::CalculateWeights.new.call(@project)

      MethSelecting::ScoresByWeightedSum.new.call(@project)

      redirect_to project_path(@project.id)
    end
  end

  def skip
    Ahp::SetDefaultWeights.new.call(@project)

    MethSelecting::ScoresByWeightedSum.new.call(@project)

    redirect_to project_path(@project.id)
  end

  def confirm
    @comparison.update!(comparison_params.merge(status: :confirmed))
    @comparison.set_value_for_inversed!

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
