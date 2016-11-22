class Item < ActiveRecord::Base
  belongs_to :user
  has_many :shaving_items
  has_many :shaving_records, :through => :shaving_items
  belongs_to :category


  has_attached_file :equipment_picture, styles:{original: "800x800>", medium: "300x300>", thumb: "100x100>"}, default_url: "missing/items/:style/missing.png"
  validates_attachment_content_type :equipment_picture, content_type: /\Aimage\/.*\z/

  def self.search(search, userid)
    year = search["(1i)"]
    month = search["(2i)"]
    where('extract(month from purchase_date) = ? AND extract(year from purchase_date) = ? AND user_id = ?',month, year, userid)
  end
end
