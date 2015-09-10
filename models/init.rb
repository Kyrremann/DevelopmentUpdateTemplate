require 'pg'

db = URI.parse('postgres://postgres:dut2015@localhost/dut')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)

require_relative 'suggestion'
require_relative 'configuration'
require_relative 'track'
require_relative 'talk'
require_relative 'comment'
