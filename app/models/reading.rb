class Reading < ActiveRecord::Base
  belongs_to :room

  delegate :home, :home_id, :home_type, to: :room, allow_nil: false
  delegate :room_type, to: :room, allow_nil: false

  scope :joins_home, -> { joins(:room, room: :home) }

  validates :key, :value, :room, presence: true

  scope :temperature, -> { where(key: 'temperature') }
  scope :humidity, -> { where(key: 'humidity') }
  scope :mould, -> { where(key: 'mould') }
  scope :normal_range, -> { where('value < 100 AND value > -5') }
  validates :key, :value, :room, presence: true
end
