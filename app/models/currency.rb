class Currency < ActiveRecord::Base
  named_scope :popular, :conditions => { :popular => true }
end
