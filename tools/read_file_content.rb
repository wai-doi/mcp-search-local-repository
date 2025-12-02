require 'mcp'
require 'json'

class ReadFileContent < MCP::Tool
  title 'Read File Content'
  description 'ローカルにあるリポジトリ内の指定されたファイルの内容を取得します。'

  input_schema(
    properties: {
      file_path: { type: 'string' }
    },
    required: ['file_path']
  )

  output_schema(
    properties: {
      content: { type: 'string', description: '指定されたファイルの内容を返します。' }
    },
    required: ['content']
  )

  annotations(
    read_only_hint: true,
    destructive_hint: false,
    idempotent_hint: true,
    open_world_hint: false,
    title: 'Read File Content'
  )

  class << self
    def call(file_path:, server_context:)
      repo_dir = server_context[:repo_dir]
      content = read_content(file_path, repo_dir)

      response_data = { content: }
      output_schema.validate_result(response_data)

      MCP::Tool::Response.new([{
        type: 'text',
        text: response_data.to_json,
        structured_content: response_data
      }])
    end

    private

    def read_content(file_path, repo_dir)
      file_path = file_path.sub(repo_dir, '') if file_path.start_with?(repo_dir)
      full_path = File.join(repo_dir, file_path)
      File.exist?(full_path) ? File.read(full_path) : ''
    end
  end
end
