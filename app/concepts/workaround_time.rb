class WorkaroundTime
  def today
    Date.current.in_time_zone('Pacific/Auckland')
  end
end
