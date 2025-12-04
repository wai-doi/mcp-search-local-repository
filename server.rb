require 'mcp'
require 'optparse'
require_relative './tools/search_files'
require_relative './tools/read_file_content'

MCP.configure do |config|
  config.exception_reporter = ->(exception, server_context) {
    $stderr.puts exception.full_message
  }
end

options = {}
opt = OptionParser.new
opt.on('--repo_dir VAL') {|v| options[:repo_dir] = v }
opt.parse!

server = MCP::Server.new(
  name: 'Search Local Repository Server',
  tools: [SearchFiles, ReadFileContent],
  server_context: { repo_dir: options[:repo_dir] }
)

transport = MCP::Server::Transports::StdioTransport.new(server)
transport.open
