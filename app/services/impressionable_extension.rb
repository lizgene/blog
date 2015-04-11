module ImpressionableExtension
  
  def self.included(klass)
    klass.extend ClassMethods
  end

  def impressions_count
    impressions.size
  end

  module ClassMethods
    def top(count)
      #could cache this, if it doesn't change often
      result = self.all.sort {|high, low| low.impressions_count <=> high.impressions_count}
      return result.first(count)
    end
  end
  
end