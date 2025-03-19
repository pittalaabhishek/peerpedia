# lib/tasks/csv_to_json.rake
require "csv"
require "json"

namespace :convert do
  desc "Convert a CSV file to JSON"
  task :csv_to_json, [ :input_file, :output_file ] => :environment do |task, args|
    input_file = args[:input_file]
    output_file = args[:output_file]

    if !File.exist?(input_file)
      puts "Error: Input file '#{input_file}' does not exist."
      exit
    end

    csv_data = CSV.read(input_file, headers: true)

    json_data = csv_data.map(&:to_hash)

    File.open(output_file, "w") do |file|
      file.write(JSON.pretty_generate(json_data))
    end

    puts "CSV data has been successfully converted to JSON and saved to '#{output_file}'."
  end
end
