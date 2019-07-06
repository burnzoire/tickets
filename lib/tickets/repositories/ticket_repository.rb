require 'yajl'
require_relative '../models/ticket.rb'

class TicketRepository

  attr_reader :data

  TAG_FIELDS = %w[tags].freeze
  FILE_PATH = './lib/tickets/data/tickets.json'.freeze

  def initialize
    json = File.new(FILE_PATH, 'r')
    parser = Yajl::Parser.new(symbolize_keys: true)
    @data = parser.parse(json)
  end

  def find(id)
    datum = data.select { |k| k[:_id] == id }&.first
    Ticket.new(datum) unless datum.nil?
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

  def search(field, keyword)
    results =
      if tag_field?(field)
        data.select do |k|
          k[field.to_sym].any? { |f| f.casecmp(keyword).zero? }
        end
      else
        data.select { |k| k[field.to_sym].to_s.casecmp(keyword).zero? }
      end

    results.map { |ticket| Ticket.new(ticket) }
  end

  private

  def tag_field?(field)
    TAG_FIELDS.include? field
  end
end
