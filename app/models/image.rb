class Image < ActiveRecord::Base
  belongs_to :menu_item

  has_attached_file :file,
                    # uncomment for database storage, which has problems with image routing
                    # :storage => :database,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :default_url => "/images/:style/missing.png"

  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/
end
