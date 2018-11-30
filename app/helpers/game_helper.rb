module GameHelper
  def not_all_days_have_clues?(game, user)
    clued_days = game.days.joins(:clues).where(clues: { user_id: user.id })
    clued_days.size < game.days.size
  end
end
