class ExpertRequestsController < ApplicationController
  before_action :find_request

  def show
    @parameter = @request.next_not_set_parameter
    @scores = @request.scores.for_parameter(@parameter.id)
  end

  def update
    params[:score_records].permit!.each do |key, value|
      @request.scores.find(key).update!(value.merge(status: :confirmed))
    end

    if @request.scores.not_set.blank?
      @request.finished!
      @request.update_total!
      redirect_to root_path, notice: 'Thanks for your expert answers!'
    else
      @request.in_progress!
      redirect_to expert_request_path(@request)
    end
  end

  private

  def find_request
    @request = ExpertRequest.find_by(id: params[:id]) || ExpertRequest.find_by(token: params[:id])
  end
end
