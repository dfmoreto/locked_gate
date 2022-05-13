module NoCustomApi
  class UnauthenticatedController < ApplicationController
    def index
      head :ok
    end
  end
end
