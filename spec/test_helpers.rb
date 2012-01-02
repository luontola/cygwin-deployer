require 'rspec'
require_relative '../lib/utils'
require_relative '../lib/template'

RSpec::Matchers.define :be_a_file do
  match do |actual|
    File.exist?(actual)
  end
end

RSpec::Matchers.define :be_a_directory do
  match do |actual|
    Dir.exist?(actual)
  end
end
