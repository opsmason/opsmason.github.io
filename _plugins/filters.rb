module Jekyll
  module Filters
    def tags_list(tags)
      tags.keys.sort_by! { |tag| tag.downcase }
    end
  end
end
