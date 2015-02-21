class Play < ActiveRecord::Base
  validates :title, presence: true
  validates :xml, presence: true
  validate :valid_xml

  protected
  def valid_xml
    true
  end
end
