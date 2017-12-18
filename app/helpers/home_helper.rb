module HomeHelper
  def pretty_tags(customer)
    pretty_tag = ""

    customer.tags.each do |tag|
      pretty_tag << "#{tag.upcase} "
    end

    pretty_tag
  end
end
