class Event < ApplicationRecord
  belongs_to :event_type
  belongs_to :user

  Reducer = Rack::Reducer.new(
    self.all,
    ->(rdate:) { by_date(rdate) },
    ->(start_date:) { where(start_date: start_date) },
    ->(end_date:) { where(end_date: end_date) },
    ->(user:) { where(user_id: user) },
    ->(event_type:) {where(event_type_id: event_type)}
  )
  scope :by_date, lambda { |rdate|
    if rdate == "hoje"
      where(start_date:  (Time.now.midnight)..Time.now.midnight + 1.day)
    else if rdate =="proximasemana"
      where(start_date:  (Time.now.midnight)..Time.now.midnight + 7.day)
    end
  end
  }
end
