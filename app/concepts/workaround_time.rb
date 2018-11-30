class WorkaroundTime
  def self.today
    Date.current.in_time_zone('Pacific/Auckland').to_date
  end
end
