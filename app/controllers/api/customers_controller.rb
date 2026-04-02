module Api
  class CustomersController < ApplicationController
    protect_from_forgery with: :null_session

    def index
      customers = Customer.order(:id)

      render json: customers.map { |c|
        {
          id: c.id,
          first_name: c.first_name,
          last_name: c.last_name,
          full_name: "#{c.first_name} #{c.last_name}",
          email: c.email,
          account_type: c.account_type,
          created_utc: c.created_at.utc.iso8601
        }
      }
    end

    def create
      customer = Customer.new(customer_params)

      if customer.save
        render json: {
          id: customer.id,
          first_name: customer.first_name,
          last_name: customer.last_name,
          full_name: "#{customer.first_name} #{customer.last_name}",
          email: customer.email,
          account_type: customer.account_type,
          created_utc: customer.created_at.utc.iso8601
        }, status: :created
      else
        render json: {
          error: "Validation failed",
          details: customer.errors.full_messages
        }, status: :unprocessable_entity
      end
    end

    def update
      customer = Customer.find(params[:id])

      if customer.update(customer_params)
        render json: {
          id: customer.id,
          first_name: customer.first_name,
          last_name: customer.last_name,
          full_name: "#{customer.first_name} #{customer.last_name}",
          email: customer.email,
          account_type: customer.account_type,
          created_utc: customer.created_at.utc.iso8601
        }
      else
        render json: {
          error: "Update failed",
          details: customer.errors.full_messages
        }, status: :unprocessable_entity
      end
    end

    def destroy
      customer = Customer.find(params[:id])
      customer.destroy

      render json: { message: "Customer deleted" }
    end

    private

    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :email, :account_type)
    end
  end
end
