require 'yajl'
require_relative '../models/organization.rb'

class OrganizationRepository

  attr_reader :data

  FILE_PATH = './lib/tickets/data/organizations.json'.freeze

  def initialize
    json = File.new(FILE_PATH, 'r')
    parser = Yajl::Parser.new
    @data = parser.parse(json)
  end

  def find(id)
    datum = data.select { |k| k['_id'] == id }&.first
    Organization.new(datum) unless datum.nil?
  end
end
