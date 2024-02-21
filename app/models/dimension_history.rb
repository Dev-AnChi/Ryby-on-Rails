class DimensionHistory < ApplicationRecord
    validates :url, :height, :width, :length, :weight, presence: true
end
