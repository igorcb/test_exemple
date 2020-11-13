class Event < ApplicationRecord
  validates :what, presence: true
end
