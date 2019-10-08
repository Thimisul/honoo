class Event < ApplicationRecord
  belongs_to :event_type
  belongs_to :user
  has_many :participants

  Reducer = Rack::Reducer.new(
    self.all,
    ->(rdate:) { by_date(rdate) },
    ->(start_date:) {where("startDAte >= ?", start_date)},
    ->(end_date:) {where("endDate <= ?", end_date)},
    ->(user:) { where(user_id: user) },
    ->(event_type:) {where(event_type_id: event_type)}
  )
  scope :by_date, lambda { |rdate|
    if rdate == "hoje"
      where(startDate:  (Time.now.midnight)..Time.now.midnight + 1.day)
    else if rdate =="proximasemana"
      where(startDate:  (Time.now.midnight)..Time.now.midnight + 7.day)
    end
  end
  }
end
