module RR
  module Expectations
    class TimesCalledExpectation
      attr_reader :scenario, :times_called
      attr_accessor :matcher

      def initialize(scenario, matcher=nil)
        @scenario = scenario
        @matcher = matcher
        @times_called = 0
        @verify_backtrace = caller[1..-1]
      end

      def attempt?
        @matcher.attempt?(@times_called)
      end

      def attempt!
        @times_called += 1
        verify_input_error unless @matcher.possible_match?(@times_called)
        return
      end

      def verify
        return false unless @matcher.is_a?(TimesCalledMatchers::TimesCalledMatcher)
        return @matcher.matches?(@times_called)
      end

      def verify!
        unless verify
          if @verify_backtrace
            error = Errors::TimesCalledError.new(error_message)
            error.backtrace = @verify_backtrace
            raise error
          else
            raise Errors::TimesCalledError, error_message
          end
        end
      end

      def terminal?
        @matcher.terminal?
      end

      protected
      def verify_input_error
        raise Errors::TimesCalledError, error_message
      end

      def error_message
        "#{scenario.formatted_name}\n#{@matcher.error_message(@times_called)}"
      end
    end
  end
end