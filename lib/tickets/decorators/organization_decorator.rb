require_relative '../models/organization'
require_relative '../models/user'
require_relative '../models/ticket'

class OrganizationDecorator
  attr_reader :model

  def initialize(model)
    @model = model
  end

  def to_s
    str = <<~STR
      Organization ##{model._id}
        name:          #{model.name}
        url:           #{model.url}
        domain_names:  #{model.domain_names.join(', ')}
        details:       #{model.details}
        created_at:    #{model.created_at}
        external_id:   #{model.external_id}
        tags:          #{model.tags.join(', ')}
    STR
    str += "\n"
    str += print_users if model.users
    str += "\n"
    str += print_tickets if model.tickets
    str
  end

  private

  def print_users
    str = "  Users:\n"
    str += '    ' + '_id'.ljust(7)
    str += 'name'.ljust(24)
    str += 'role'.ljust(14)
    str += 'active'.ljust(7)
    str += "verified\n"

    model.users.each do |user|
      str += '    ' + user._id.to_s.ljust(7)
      str += user.name.ljust(24)
      str += user.role.ljust(14)
      str += user.active.to_s.ljust(7)
      str += user.verified.to_s
      str += "\n"
    end
    str
  end

  def print_tickets
    str = "  Tickets:\n"
    str += '    ' + 'subject'.ljust(45)
    str += 'priority'.ljust(12)
    str += "status\n"

    model.tickets.each do |ticket|
      str += '    ' + ticket.subject.ljust(45)
      str += ticket.priority.ljust(12)
      str += ticket.status.to_s
      str += "\n"
    end
    str
  end
end
