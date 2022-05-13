module CustomApi
  class NoCustomAuthenticatedController < ApiController
    def index
      head :ok
    end
  end
end
