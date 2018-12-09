class OversightsController < ApplicationController
  before_action :authenticate_user!, :find_game, :require_creator

  def show
    clues_by_user_id = @game.clues.group_by(&:user_id)
    clue_information = @game.users.map do |user|
      num_entered = clues_by_user_id.fetch(user.id, []).size

      {
        id:     user.id,
        name:   user.name,
        number: num_entered,
      }
    end

    @user_info_by_entries = clue_information.group_by { |h| h[:number] }.sort_by(&:first)
  end
end
