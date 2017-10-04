module TwitterApi
  Error = Class.new(StandardError)

  class ArgumentError < Error
    def title
      'Bad Request'
    end
  end
end
