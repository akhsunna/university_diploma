class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = current_user.projects
    @project = Project.new
  end

  def show

  end

  def create
    @project = Project.new(project_params.merge(user: current_user))
    @project.save!

    # creates records for ahp
    Parameter.find_each do |param_a|
      Parameter.find_each do |param_b|
        value, inversed =
          if param_a.id == param_b.id
            [1, false]
          else
            ParametersComparison.default_for(param_a.id, param_b.id)
          end
        ParametersComparison.create(
          parameter_a: param_a,
          parameter_b: param_b,
          project: @project,
          value: value,
          inversed: inversed,
          status: param_a.id == param_b.id ? :confirmed : :not_set
        )
      end
    end

    redirect_to compare_project_parameters_comparisons_path(project_id: @project.id)
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
