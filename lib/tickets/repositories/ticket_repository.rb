require 'yajl'
require_relative '../models/ticket.rb'

class TicketRepository

  attr_reader :data

  FILE_PATH = './lib/tickets/data/tickets.json'.freeze

  def initialize
    json = File.new(FILE_PATH, 'r')
    parser = Yajl::Parser.new
    @data = parser.parse(json)
  end

  def find(id)
    datum = data.select { |k| k['_id'] == id }&.first
    Ticket.new(datum) unless datum.nil?
  end

  def by_organization(org_id)
    tickets = data.select { |k| k['organization_id'] == org_id }
    tickets.map { |u| Ticket.new(u) }
  end
end
