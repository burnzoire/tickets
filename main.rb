require_relative './lib/tickets/services/search_service'
require_relative './lib/tickets/decorators/organization_decorator'

puts '*' * 50
puts "*#{' ' * 48}*"
puts "*#{'ZENDESK SEARCH'.center(48)}*"
puts "*#{' ' * 48}*"
puts '*' * 50
puts "\n"

category, field, keyword, results = nil
awaiting_input = true

fields = {
  organizations: %w[_id name details domain_names tags url external_id shared_tickets],
  users: %w[_id name alias],
  tickets: %w[_id subject description tags]
}

while awaiting_input
  if category.nil?
    puts "\n"
    puts 'Choose from the following:'
    puts "[1] Organizations\n" \
         "[2] Users\n" \
         "[3] Tickets\n"
    puts 'Press Q to quit any time.'
    selection = $stdin.gets.chomp.downcase

    if selection == '1'
      category = :organizations
    elsif selection == '2'
      category = :users
    elsif selection == '3'
      category = :tickets
    elsif selection == 'q'
      awaiting_input = false
    else
      puts 'Unknown selection'
    end
  elsif field.nil?
    puts "\n"
    puts "Searching #{category}. Select a field:"
    puts fields[category].each_with_index.map { |c, i| "[#{i + 1}] #{c}" }.join("\n")
    selection = $stdin.gets.chomp.downcase
    if selection.to_i.positive? && selection.to_i <= fields[category].count
      field = fields[category][selection.to_i - 1]
    elsif selection == 'q'
      awaiting_input = false
    else
      puts 'Unknown selection'
    end
  elsif keyword.nil?
    puts "\n"
    puts "Searching on #{field}. Enter keyword:"
    keyword = $stdin.gets.chomp
    results = SearchService.new.public_send("search_#{category}", field, keyword)
    decorator = Object.const_get "#{category.to_s.chop.capitalize}Decorator"
    puts "\n"
    puts "Searching #{category} where #{field} = #{keyword}.\n\n"
    puts "Found #{results.count} results...\n\n"
    results.each do |result|
      puts decorator.new(result)
      puts "\n"
    end
  elsif results
    puts "\n"
    puts 'Another search? [Y/N]'
    selection = $stdin.gets.chomp.downcase
    if selection == 'y'
      category, field, keyword, results = nil
    elsif %w[n q].include? selection
      awaiting_input = false
    else
      puts 'Unknown selection'
    end
  end
end
