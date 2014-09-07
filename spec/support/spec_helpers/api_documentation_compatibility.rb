module SpecHelpers
  module ApiDocumentationCompatibility
    def response_body
      return super if defined? super
      response.body
    end

    def status
      return super if defined? super
      response.status
    end
  end
end
