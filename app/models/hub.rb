class Hub < ActiveRecord::Base
  include AuthUtilities
  include ModelExtensions

  attr_accessible :title, :description, :tag_prefix
  acts_as_authorization_object
  has_many :hub_feeds, :dependent => :destroy
  has_many :hub_tag_filters, :dependent => :destroy
  has_many :republished_feeds, :dependent => :destroy
  has_many :feeds, :through => :hub_feeds

  def display_title
    self.title
  end

  alias :to_s :display_title

end
