require_relative File.expand_path('../repositories/organization_repository', __dir__)
require_relative File.expand_path('../repositories/ticket_repository', __dir__)
require_relative File.expand_path('../repositories/user_repository', __dir__)

class SearchService

  def search_organizations(field, keyword)
    organizations = organization_repository.search(field, keyword)

    organizations.each do |organization|
      organization.load_users(user_repository)
      organization.load_tickets(ticket_repository)
    end
  end

  def search_users(_field, _keyword)
    raise 'not implemented'
  end

  def search_tickets(_field, _keyword)
    raise 'not_implemented'
  end

  private

  def organization_repository
    @organization_repository ||= OrganizationRepository.new
  end

  def user_repository
    @user_repository ||= UserRepository.new
  end

  def ticket_repository
    @ticket_repository ||= TicketRepository.new
  end
end
