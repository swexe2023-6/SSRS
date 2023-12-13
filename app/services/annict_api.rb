# GraphQLクライアントの設定
require 'graphql/client'
require 'graphql/client/http'

module AnnictAPI
  # AnnictのGraphQLエンドポイント
  HTTP = GraphQL::Client::HTTP.new("https://api.annict.com/graphql") do
    def headers(context)
      # APIキーをヘッダーに設定
      { "Authorization" => "M8-bsBmtHydMAhRzuoWiWbPebgfy8erRJ3mHRFXUFI4" }
    end
  end

  Schema = GraphQL::Client.load_schema(HTTP)
  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)

  MyQuery = Client.parse <<-'GRAPHQL'
    query {
  searchWorks(
    seasons: ["2018-autumn"],
    orderBy: { field: WATCHERS_COUNT, direction: DESC },
    first: 3
  ) {
    edges {
      node {
        annictId
        title
        watchersCount
      }
    }
  }
}
    GRAPHQL

# APIからJSONデータを取得
    def self.fetch_data
        response = Client.query(MyQuery)
        if response.data
            response.to_h.to_json
        else
            # エラー処理
            {error: response.errors[:data] }.to_json
        end
    end
end
