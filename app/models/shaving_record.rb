class ShavingRecord < ActiveRecord::Base
  belongs_to :user
  has_many :shaving_items
  has_many :items, :through => :shaving_items

  accepts_nested_attributes_for :items
  accepts_nested_attributes_for :shaving_items

  has_attached_file :picture, styles:{original: "800x800>", medium: "300x300>", thumb: "100x100>"}, default_url: "missing/shave_record/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
end
