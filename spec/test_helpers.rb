# Copyright © 2012 Esko Luontola <www.orfjackal.net>
# This software is released under the Apache License 2.0.
# The license text is at http://www.apache.org/licenses/LICENSE-2.0

require 'rspec'
require_relative '../lib/utils'
require_relative '../lib/template_copier'

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
