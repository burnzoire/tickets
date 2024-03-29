require_relative '../models/organization'
require_relative '../models/user'
require_relative '../models/ticket'

class UserDecorator
  attr_reader :model

  def initialize(model)
    @model = model
  end

  def to_s
    str = <<~STR
      User ##{model._id}
        name:          #{model.name}
        url:           #{model.url}
        organization:  #{organization}
        created_at:    #{model.created_at}
        tags:          #{model.tags.join(', ')}
    STR
    str += "\n"
    str += print_tickets('Submitted Tickets:', model.submitted_tickets) if model.submitted_tickets
    str += "\n"
    str += print_tickets('Assigned Tickets:', model.assigned_tickets) if model.assigned_tickets
    str
  end

  private

  def print_tickets(title, tickets)
    str = "  #{title}\n"
    str += '    ' + 'subject'.ljust(45)
    str += 'priority'.ljust(12)
    str += "status\n"

    tickets.each do |ticket|
      str += '    ' + ticket.subject.ljust(45)
      str += ticket.priority.ljust(12)
      str += ticket.status.to_s
      str += "\n"
    end
    str
  end

  def organization
    model&.organization&.name
  end
end
