class Currency < ActiveRecord::Base
  scope :known,     -> { where('rate IS NOT NULL') }
  scope :popular,   -> { where('popular = ?', true) }
  scope :unpopular, -> { where('popular = ?', false) }
end
