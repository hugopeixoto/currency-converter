class Currency < ActiveRecord::Base
  named_scope :popular, :conditions => { :popular => true }
  named_scope :unpopular, :conditions => { :popular => false }
end
