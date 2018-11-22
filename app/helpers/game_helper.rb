module GameHelper
  def not_all_days_have_clues?(game)
    game.days.order("days.created_at DESC").includes(:clues).where(clues: { id: nil } ).last.date <= game.game_end_date
  end
end
