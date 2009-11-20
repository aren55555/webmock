if defined?(Test::Unit::TestCase)
  
  class Test::Unit::TestCase
    include WebMock
    alias setup_without_webmock setup
    def setup
      reset_webmock
      @original_allow_net_connect = WebMock.net_connect_allowed?
      WebMock.disable_net_connect!
    end

    alias teardown_without_webmock teardown
    def teardown
      @original_allow_net_connect ? WebMock.allow_net_connect! : WebMock.disable_net_connect!
    end
  end
  
  module WebMock
    private
    def assertion_failure(message)
       raise Test::Unit::AssertionFailedError.new(message)
    end
  end
  
end