class AuthenticatedController < ApplicationController
  include LockedGate
  before_action :authenticate_user!

  def index
    head :ok
  end
end
