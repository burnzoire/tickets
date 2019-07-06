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
      Ticket ##{model._id}
        subject:          #{model.subject}
        url:           #{model.url}
        created_at:    #{model.created_at}
        tags:          #{model.tags.join(', ')}
    STR
  end
end
