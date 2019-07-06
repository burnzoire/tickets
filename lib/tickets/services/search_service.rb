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

  def search_users(field, keyword)
    users = user_repository.search(field, keyword)

    users.each do |user|
      user.load_organization(organization_repository)
      user.load_tickets(ticket_repository)
    end
  end

  def search_tickets(field, keyword)
    tickets = ticket_repository.search(field, keyword)

    tickets.each do |ticket|
      ticket.load_organization(organization_repository)
      ticket.load_users(user_repository)
    end
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
