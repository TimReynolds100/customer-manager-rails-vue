module Api
  class StatusController < ApplicationController
    def index
      render json: {
        service: "myapp",
        status: "ok",
        timestamp_utc: Time.now.utc.iso8601,
        environment: Rails.env,
        method: request.method,
        path: request.path
      }
    end
  end
end
