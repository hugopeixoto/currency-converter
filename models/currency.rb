class Currency < ActiveRecord::Base
  scope :popular, :conditions => { :popular => true }
  scope :unpopular, :conditions => { :popular => false }
end
