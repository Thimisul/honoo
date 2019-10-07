class EventType < ApplicationRecord
    has_many :events, class_name: "event", foreign_key: "reference_id"
end
