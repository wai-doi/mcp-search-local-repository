require 'mcp'
require 'json'

class SearchFiles < MCP::Tool
  LIMIT_COUNT = 1000

  title 'Search Files'
  description 'ローカルにあるリポジトリ内で指定されたキーワードを含むファイルを検索します。'

  input_schema(
    properties: {
      keyword: { type: 'string' }
    },
    required: ['keyword']
  )

  output_schema(
    properties: {
      files: { type: 'array', items: { type: 'string' }, description: "検索結果のファイルパスのリスト。最大#{LIMIT_COUNT}件を返します。" },
      too_many_files: { type: 'boolean', description: "#{LIMIT_COUNT}件を超える場合にtrueを返します。" }
    },
    required: ['files', 'too_many_files']
  )

  annotations(
    read_only_hint: true,
    destructive_hint: false,
    idempotent_hint: true,
    open_world_hint: false,
    title: 'Search Files'
  )

  class << self
    def call(keyword:, server_context:)
      repo_dir = server_context[:repo_dir]
      files = search(keyword, repo_dir)
      too_many_files = false

      if files.size > LIMIT_COUNT
        files = files.first(LIMIT_COUNT)
        too_many_files = true
      end

      response_data = { files:, too_many_files: }
      output_schema.validate_result(response_data)

      MCP::Tool::Response.new([{
        type: 'text',
        text: response_data.to_json,
        structured_content: response_data
      }])
    end

    private

    def search(keyword, repo_dir)
      command = %(rg --files-with-matches "#{keyword}" "#{repo_dir}")
      `#{command}`.lines(chomp: true)
    end
  end
end
