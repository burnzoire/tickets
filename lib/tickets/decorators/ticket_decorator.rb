require_relative '../models/organization'
require_relative '../models/user'
require_relative '../models/ticket'

class TicketDecorator
  attr_reader :model

  def initialize(model)
    @model = model
  end

  def to_s
    <<~STR
      Ticket ##{model._id}:
        subject:       #{model.subject}
        type:          #{model.type}
        priority:      #{model.priority}
        status:        #{model.status}
        description    #{model.description}
        submitted by:  #{model.submitter.name}
        assigned to    #{model.assignee.name}
        organization:  #{model.organization.name}
        url:           #{model.url}
        created_at:    #{model.created_at}
        tags:          #{model.tags.join(', ')}
    STR
  end
end
