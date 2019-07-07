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
        submitted by:  #{submitted_by}
        assigned to    #{assigned_to}
        organization:  #{model.organization.name}
        url:           #{model.url}
        created_at:    #{model.created_at}
        tags:          #{model.tags.join(', ')}
    STR
  end

  private

  def submitted_by
    model&.submitter&.name
  end

  def assigned_to
    model&.assignee&.name
  end
end
