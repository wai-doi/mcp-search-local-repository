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

## コマンドラインからの実行

リポジトリを指定してサーバーを起動して、コマンドラインからリクエストを送信することで、動作を確認できます。

```bash
bundle exec ruby server.rb --repo_dir=/path/to/your/repo
```

サーバーが起動したら入力待ちの状態になるので、JSON-RPC リクエストを標準入力から送信します。例えばキーワードでファイルを検索するリクエストは以下の通りです

```json
{"jsonrpc":"2.0","id":"1","method":"tools/call","params":{"name":"search_files","arguments":{"keyword":"foo"}}}
```
