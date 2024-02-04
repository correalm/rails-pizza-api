require 'json-schema'

RSpec::Matchers.define :match_schema do |expect|
  match do |actual|
    schema_path = "#{Dir.pwd}/spec/support/api/schemas/#{expect}.json"
    JSON::Validator.validate!(schema_path, actual)
  end
end
