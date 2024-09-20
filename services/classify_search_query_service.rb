class ClassifySearchQueryService
  def initialize(query, search_id: nil)
    @query = query
    @client = OpenAI::Client.new
    @search_id = search_id
  end

  def call
    @client.add_headers(
      "velvet-metadata-service": "ClassifySearchQueryService",
      "velvet-metadata-search-id": @search_id.to_s,
      "velvet-cache-enabled": "true",
    )

    response = @client.chat(
      parameters: {
        model: "ft:gpt-4o-mini:my-org:custom_suffix:id",
        messages: [
          { role: "user", content: "Given a user's query, your job is to determine whether they are searching for 'companies' or 'people'. Respond with JSON in the format of {\"search_type\": \"companies\"} or {\"search_type\": \"people\"}. Make a best guess and always return one of those two." },
          { role: "user", content: @query }
        ],
        temperature: 0.7,
        response_format: { "type": "json_object" }
      }
    )
    JSON.parse(response.dig("choices", 0, "message", "content"))["search_type"]
  end

  def self.verify_expected_results
    tests = {
      "female founders in SF" => "people",
      "engineers named John" => "people",
      "contacts at Google" => "people",
      "tech startups in SF" => "companies",
      "companies hiring remote" => "companies",
      "best AI companies" => "companies"
    }

    tests.each do |query, expected_result|
      service = ClassifySearchQueryService.new(query)
      result = service.call
      if result == expected_result
        puts "Test passed for query: '#{query}'"
      else
        raise 
        puts "Test failed for query: '#{query}'. Expected: '#{expected_result}', Got: '#{result}'"
      end
    end
  end
end
