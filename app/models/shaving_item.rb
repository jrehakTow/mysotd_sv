class ShavingItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :shaving_record
end
