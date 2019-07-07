module BasicSearch
  def find(id)
    datum = data.select { |k| k[:_id] == id }&.first
    model_class.new(datum) unless datum.nil?
  end

  def search(field, keyword)
    results =
      if tag_field?(field)
        data.select do |k|
          k[field.to_sym].any? { |f| f.casecmp(keyword).zero? }
        end
      else
        data.select { |k| k[field.to_sym].to_s.casecmp(keyword).zero? }
      end

    results.map { |result| model_class.new(result) }
  end

  def model_class
    Object.const_get self.class.name.chomp('Repository')
  end

  private

  def tag_field?(field)
    tag_fields.include? field
  end
end
