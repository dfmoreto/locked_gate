module NoCustomApi
  class AuthenticatedController < ApiController
    def index
      head :ok
    end
  end
end
