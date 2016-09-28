# frozen_string_literal: true
class Sensor < ActiveRecord::Base
  belongs_to :home
  has_many :readings

  def temperature
    Reading.where(sensor: self, sub_type: V_TEMP)
           .order(created_at: :desc)
           .first
           .value
  rescue
    nil
  end

  def humidity
    Reading.where(sensor_id: id, sub_type: V_HUM)
           .order(created_at: :desc)
           .first
           .value
  rescue
    nil
  end

  V_TEMP = 0
  V_HUM = 1
end
