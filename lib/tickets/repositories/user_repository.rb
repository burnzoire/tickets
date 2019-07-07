require 'yajl'
require_relative '../models/user.rb'

class UserRepository
  include BasicSearch
  attr_reader :data

  FILE_PATH = './lib/tickets/data/users.json'.freeze

  def initialize
    json = File.new(FILE_PATH, 'r')
    parser = Yajl::Parser.new(symbolize_keys: true)
    @data = parser.parse(json)
  end

  def by_organization(org_id)
    users = data.select { |k| k[:organization_id] == org_id }
    users.map { |u| User.new(u) }
  end

  def tag_fields
    %w[tags]
  end
end
