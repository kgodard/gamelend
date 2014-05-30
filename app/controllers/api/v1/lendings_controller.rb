class Api::V1::LendingsController < ApplicationController
  respond_to :json

  def create
    lending = Lending.new(lending_params)
    if lending.save
      render_json_response :ok
    else
      errors = lending.errors.full_messages.uniq.to_sentence
      render_json_response :error, :message => errors
    end
  end

  def destroy
    lending = find_lending
    if lending.destroy
      render_json_response :ok
    else
      render_json_response :error, :message => 'could not delete lending'
    end
  rescue ActiveRecord::RecordNotFound
    render_json_response :error, :message => "could not find lending with id: #{params[:id]}"
  end

  private

  def find_lending
    Lending.find(params[:id])
  end

  def lending_params
    params.require(:lending).permit(:game_id, :borrower_id, :return_on)
  end
end
