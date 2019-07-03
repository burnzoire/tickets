class Organization

  attr_reader :_id,
              :url,
              :external_id,
              :name,
              :domain_names,
              :created_at,
              :details,
              :shared_tickets,
              :tags

  def initialize(attributes)
    @_id = attributes['_id']
    @url = attributes['url']
    @external_id = attributes['external_id']
    @name = attributes['name']
    @domain_names = attributes['domain_names']
    @created_at = attributes['created_at']
    @details = attributes['details']
    @shared_tickets = attributes['shared_tickets']
    @tags = attributes['tags']
  end

  def to_s
    "Organization ##{_id} #{name}"
  end

end
