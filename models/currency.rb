class Currency < ActiveRecord::Base
  default_scope where('rate IS NOT NULL')
  scope :popular, where('popular = ?', true)
  scope :unpopular, where('popular = ?', false)
end
