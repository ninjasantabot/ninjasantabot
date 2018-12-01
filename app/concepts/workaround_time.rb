class WorkaroundTime
  def self.today
    Time.now.in_time_zone('Pacific/Auckland').to_date
  end
end
