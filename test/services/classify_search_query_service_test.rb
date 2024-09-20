require "test_helper"

class ClassifySearchQueryServiceTest < ActiveSupport::TestCase
  def setup
    @client = Minitest::Mock.new
    OpenAI::Client.stub :new, @client do
      yield
    end
  end

  def test_returns_people_for_people_queries
    queries = [
      "female founders in SF",
      "engineers named John",
      "contacts at Google"
    ]

    queries.each do |query|
      @client.expect :add_headers, nil, [ Hash ]
      @client.expect :chat, {
        "choices" => [
          {
            "message" => {
              "content" => '{ "search_type": "people" }'
            }
          }
        ]
      }, [ Hash ]

      service = ClassifySearchQueryService.new(query)
      result = service.call
      assert_equal "people", result

      @client.verify
    end
  end

  def test_returns_companies_for_company_queries
    queries = [
      "tech startups in SF",
      "companies hiring remote",
      "best AI companies"
    ]

    queries.each do |query|
      @client.expect :add_headers, nil, [ Hash ]
      @client.expect :chat, {
        "choices" => [
          {
            "message" => {
              "content" => '{ "search_type": "companies" }'
            }
          }
        ]
      }, [ Hash ]

      service = ClassifySearchQueryService.new(query)
      result = service.call
      assert_equal "companies", result

      @client.verify
    end
  end
end
