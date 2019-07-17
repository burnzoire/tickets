require 'yajl'
require_relative '../models/ticket.rb'
require_relative './basic_search.rb'

class TicketRepository
  attr_reader :data
  include BasicSearch

  FILE_PATH = './lib/tickets/data/tickets.json'.freeze

  def initialize
    json = File.new(FILE_PATH, 'r')
    parser = Yajl::Parser.new(symbolize_keys: true)
    @data = parser.parse(json)
  end

  def by_organization(org_id)
    tickets = data.select { |k| k[:organization_id] == org_id }
    tickets.map { |u| Ticket.new(u) }
  end

  def by_submitter(user_id)
    tickets = data.select { |k| k[:submitter_id] == user_id }
    tickets.map { |u| Ticket.new(u) }
  end

  def by_assignee(user_id)
    tickets = data.select { |k| k[:assignee_id] == user_id }
    tickets.map { |u| Ticket.new(u) }
  end

  def tag_fields
    %w[tags]
  end

  def boolean_fields
    %w[has_incidents]
  end
end
