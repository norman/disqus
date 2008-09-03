require 'test/unit'
require 'yaml'
require 'disqus'
require 'disqus/api'
require 'mocha'

DISQUS_TEST = YAML.load(File.read(File.dirname(__FILE__) + "/config.yml"))

class ApiTest < Test::Unit::TestCase
  
  def setup
    Disqus.defaults[:api_key] = DISQUS_TEST["api_key"]
  end
  
  def test_get_forum_list
    mock_response('get_forum_list.json')
    forum_list = Disqus::Api::get_forum_list
    assert_equal "Disqus Test", forum_list["message"][0]["name"]
  end
  
  def test_get_forum_api_key
    mock_response('get_forum_api_key.json')
    forum_api_key = Disqus::Api::get_forum_api_key(:forum_id => 1234)
    assert_equal "FAKE_FORUM_API_KEY", forum_api_key["message"]
  end
  
  private
  
  def mock_response(file)
    Disqus::Api.expects(:get).returns(File.read(File.dirname(__FILE__) + "/responses/#{file}"))  
  end

end