class Customer < ApplicationRecord
  serialize :tags, Array

  validate :check_tags

  belongs_to :shop

  private

  def check_tags
    valid_tags = ['new', 'repeat', 'vip']

    tags.each do |tag|
      return false if valid_tags.exclude?(tag)
    end
  end
end
