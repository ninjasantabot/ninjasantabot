class WorkaroundTime
  def self.today
    Time.now.in_time_zone('Pacific/Auckland').to_date
  end

  def self.now
    Time.now.in_time_zone('Pacific/Auckland')
  end

  def self.midday_of(date)
    date.in_time_zone('Pacific/Auckland').midday
  end
end
