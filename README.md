# mcp-search-local-repository

ローカルリポジトリ内でファイルを検索し、その内容を取得するためのローカル MCP サーバーです。

## 機能

- SearchFiles: 指定されたキーワードにマッチするファイルをローカルリポジトリ内で検索します。
- ReadFileContent: 指定されたファイルの内容を取得します。

## セットアップ

### 動作環境

- Ruby
- Bundler
- [ripgrep](https://github.com/BurntSushi/ripgrep) (`rg` コマンド)

### インストール

```bash
bundle install
```

### GitHub Copilot での使用方法

VS Code の GitHub Copilot で MCP サーバーを使用するには、`.vscode/mcp.json` に設定を追加します。

例として、ローカルにクローンした [Rails リポジトリ](https://github.com/rails/rails) と [Rails ガイドのリポジトリ](https://github.com/yasslab/railsguides.jp) を検索する設定は以下の通りです：

```json
{
  "servers": {
    "search-rails": {
      "command": "bundle",
      "args": [
        "exec",
        "ruby",
        "/path/to/mcp-search-local-repository/server.rb",
        "--repo_dir=/path/to/rails"
      ]
    },
    "search-rails-guide": {
      "command": "bundle",
      "args": [
        "exec",
        "ruby",
        "/path/to/mcp-search-local-repository/server.rb",
        "--repo_dir=/path/to/railsguides.jp"
      ]
    }
  }
}
```

**注意**: `/path/to/` の部分は、実際のリポジトリのパスに置き換えてください。
