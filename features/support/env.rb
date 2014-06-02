require 'rspec/expectations'

DEFAULT_PORT = 5000
DEFAULT_TIMEOUT = 2

ROOT_FOLDER = Dir.pwd
OSM_USER = 'osrm'
OSM_GENERATOR = 'osrm-test'
OSM_UID = 1
TEST_FOLDER = File.join ROOT_FOLDER, 'test'
DATA_FOLDER = 'cache'
OSM_TIMESTAMP = '2000-00-00T00:00:00Z'
DEFAULT_SPEEDPROFILE = 'bicycle'
WAY_SPACING = 100
DEFAULT_GRID_SIZE = 100   #meters
PROFILES_PATH = File.join ROOT_FOLDER, 'profiles'
BIN_PATH = File.join ROOT_FOLDER, 'build'
DEFAULT_INPUT_FORMAT = 'osm'
DEFAULT_ORIGIN = [1,1]
LAUNCH_TIMEOUT = 1
SHUTDOWN_TIMEOUT = 1


def log_time_and_run cmd
  log_time cmd
  `#{cmd}`
end

def log_time cmd
  puts "[#{Time.now.strftime('%Y-%m-%d %H:%M:%S:%L')}] #{cmd}"
end




puts "Ruby version #{RUBY_VERSION}"
unless RUBY_VERSION.to_f >= 1.9
  raise "*** Please upgrade to Ruby 1.9.x to run the OSRM cucumber tests"
end

if ENV["OSRM_PORT"]
  OSRM_PORT = ENV["OSRM_PORT"].to_i
  puts "Port set to #{OSRM_PORT}"
else
  OSRM_PORT = DEFAULT_PORT
  puts "Using default port #{OSRM_PORT}"
end

if ENV["OSRM_TIMEOUT"]
  OSRM_TIMEOUT = ENV["OSRM_TIMEOUT"].to_i
  puts "Timeout set to #{OSRM_TIMEOUT}"
else
  OSRM_TIMEOUT = DEFAULT_TIMEOUT
  puts "Using default timeout #{OSRM_TIMEOUT}"
end

unless File.exists? TEST_FOLDER
  raise "*** Test folder #{TEST_FOLDER} doesn't exist."
end


AfterConfiguration do |config|
  clear_log_files
end

at_exit do
  OSRMLoader.shutdown
end