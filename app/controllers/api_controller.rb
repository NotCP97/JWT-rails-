class ApiController < ApplicationController
    puts "api_controller_out"
    before_action :run_api
  
    def run_api
      puts "api_controller_in"
  
      service,api_path =   request.path.split('/')
  
      puts api_path

      
  
      interaction = api_path.camelcase

      auth_token = request.headers["token"]
      puts auth_token

  
      request_params = request.query_parameters.deep_symbolize_keys
      if  eval(request.raw_post).present?
        request_params =  request_params.merge(eval(request.raw_post)).deep_symbolize_keys
      end



      @api_request = ApiRequest.new(interaction,request_params,auth_token)
  

      
     # self.interaction_params = @api_request.request_params
      
      @api_request.set_session_data

      if @api_request.is_unauthenticated?
        render json: {}, status: :unauthorized and return
      end
      begin
        @api_request.set_response
      end
  
      if @api_request.is_bad_request?
        render json: @api_request.validation_errors, status: :bad_request and return
      end
  
      render json: @api_request.result, status: :ok and return
    end



  
  
  
  end
  