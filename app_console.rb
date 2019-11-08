require 'pg'
require 'pry' if development?

Dir[File.join(__dir__, 'models', '*.rb')].each { |file| require file }


binding.pry()
