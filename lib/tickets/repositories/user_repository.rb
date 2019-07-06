require 'yajl'
require_relative '../models/user.rb'

class UserRepository

  attr_reader :data

  TAG_FIELDS = %w[tags].freeze
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

  def find(id)
    datum = data.select { |k| k[:_id] == id }&.first
    User.new(datum) unless datum.nil?
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

    results.map { |ticket| User.new(ticket) }
  end

  private

  def tag_field?(field)
    TAG_FIELDS.include? field
  end
end
