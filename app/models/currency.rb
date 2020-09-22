class Currency < ActiveRecord::Base
  scope :popular, -> { where(popular: true) }
  scope :unpopular, -> { where(popular: false) }
end
