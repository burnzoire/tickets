class Ticket

  attr_reader :_id,
              :url,
              :external_id,
              :created_at,
              :type,
              :subject,
              :description,
              :priority,
              :status,
              :submitter_id,
              :assignee_id,
              :organization_id,
              :tags,
              :has_incidents,
              :due_at,
              :via

  def initialize(attributes)
    @_id = attributes['_id']
    @url = attributes['url']
    @external_id = attributes['external_id']
    @created_at = attributes['created_at']
    @type = attributes['type']
    @subject = attributes['subject']
    @description = attributes['description']
    @priority = attributes['priority']
    @status = attributes['status']
    @submitter_id = attributes['submitter_id']
    @assignee_id = attributes['assignee_id']
    @organization_id = attributes['organization_id']
    @tags = attributes['tags']
    @has_incidents = attributes['has_incidents']
    @due_at = attributes['due_at']
    @via = attributes['via']
  end

  def to_s
    "Ticket ##{_id} #{subject} (#{status})"
  end

end
