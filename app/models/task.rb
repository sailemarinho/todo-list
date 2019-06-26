class Task < ApplicationRecord
  has_many :events, dependent: :destroy
end
