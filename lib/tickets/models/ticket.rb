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

  attr_accessor :organization, :submitter, :assignee

  def initialize(attributes)
    @_id = attributes[:_id]
    @url = attributes[:url]
    @external_id = attributes[:external_id]
    @created_at = attributes[:created_at]
    @type = attributes[:type]
    @subject = attributes[:subject]
    @description = attributes[:description]
    @priority = attributes[:priority]
    @status = attributes[:status]
    @submitter_id = attributes[:submitter_id]
    @assignee_id = attributes[:assignee_id]
    @organization_id = attributes[:organization_id]
    @tags = attributes[:tags]
    @has_incidents = attributes[:has_incidents]
    @due_at = attributes[:due_at]
    @via = attributes[:via]
  end

  def to_s
    "Ticket ##{_id} #{subject} (#{status})"
  end

  def load_organization(repo)
    raise 'Bad repository' unless repo.is_a? OrganizationRepository

    @organization = repo.find(organization_id)
  end

  def load_users(repo)
    raise 'Bad repository' unless repo.is_a? UserRepository

    @submitter = repo.find(submitter_id)
    @assignee = repo.find(assignee_id)
  end
end
