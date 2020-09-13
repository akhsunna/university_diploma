class ParametersComparisonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_comparison, only: %i[skip confirm]

  def compare
    @comparison = @project.next_for_compare

    # unless @comparison
    #   redirect_to root_path
    # end
  end

  def skip
    @comparison.skip!
    redirect_to compare_project_parameters_comparisons_path(project_id: params[:project_id])
  end

  def confirm
    @comparison.update!(comparison_params.merge(status: :confirmed))
    # TODO: set value for inversed
    redirect_to compare_project_parameters_comparisons_path(project_id: params[:project_id])
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
