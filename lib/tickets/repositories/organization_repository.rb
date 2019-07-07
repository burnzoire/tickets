require 'yajl'
require_relative '../models/organization'
require_relative 'basic_search'

class OrganizationRepository
  include BasicSearch
  attr_reader :data

  FILE_PATH = './lib/tickets/data/organizations.json'.freeze

  def initialize
    json = File.new(FILE_PATH, 'r')
    parser = Yajl::Parser.new(symbolize_keys: true)
    @data = parser.parse(json)
  end

  def tag_fields
    %w[domain_names tags]
  end
end
