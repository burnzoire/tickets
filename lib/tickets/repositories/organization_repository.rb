require 'yajl'
require_relative '../models/organization.rb'

class OrganizationRepository

  attr_reader :data

  TAG_FIELDS = %w[domain_names tags].freeze
  FILE_PATH = './lib/tickets/data/organizations.json'.freeze

  def initialize
    json = File.new(FILE_PATH, 'r')
    parser = Yajl::Parser.new(symbolize_keys: true)
    @data = parser.parse(json)
  end

  def find(id)
    datum = data.select { |k| k[:_id] == id }&.first
    Organization.new(datum) unless datum.nil?
  end

  def search(field, keyword)
    organizations =
      if tag_field?(field)
        data.select do |k|
          k[field.to_sym].any? { |f| f.casecmp(keyword).zero? }
        end
      else
        data.select { |k| k[field.to_sym].to_s.casecmp(keyword).zero? }
      end

    organizations.map { |organization| Organization.new(organization) }
  end

  private

  def tag_field?(field)
    TAG_FIELDS.include? field
  end
end
