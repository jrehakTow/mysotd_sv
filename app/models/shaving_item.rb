class ShavingItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :shaving_record

  #attr_accessible :item_id, :shaving_record_id

end
