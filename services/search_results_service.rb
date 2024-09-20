require 'openai'

class SearchResultsService
  def initialize(query, scope, search_id: nil)
    @query = query
    @scope = scope
    @client = OpenAI::Client.new
    @search_id = search_id
  end

  def call
    @client.add_headers(
      "velvet-metadata-service": "SearchResultsService",
      "velvet-metadata-search-id": @search_id.to_s
    )

    response = @client.chat(
      parameters: {
        model: "gpt-4o",
        messages: [
          { role: "user", content: "Respond to the user query in JSON with a list of 3-5 #{@scope}. It should be an array of names under the key \"results\", like: {\"results\": [\"name1\", \"name2\", \"name3\"]}" },
          { role: "user", content: @query }
        ],
        temperature: 0.7,
        response_format: { "type": "json_object" }
      }
    )
    JSON.parse(response.dig("choices", 0, "message", "content"))
  end
end
