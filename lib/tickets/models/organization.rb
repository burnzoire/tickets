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

  attr_accessor :users, :tickets

  def initialize(attributes)
    @_id = attributes[:_id]
    @url = attributes[:url]
    @external_id = attributes[:external_id]
    @name = attributes[:name]
    @domain_names = attributes[:domain_names]
    @created_at = attributes[:created_at]
    @details = attributes[:details]
    @shared_tickets = attributes[:shared_tickets]
    @tags = attributes[:tags]
  end

  def to_s
    "Organization ##{_id} #{name}"
  end

  def load_users(repo)
    raise 'Bad repository' unless repo.is_a? UserRepository

    @users = repo.by_organization(_id)
  end

  def load_tickets(repo)
    raise 'Bad repository' unless repo.is_a? TicketRepository

    @tickets = repo.by_organization(_id)
  end

end
