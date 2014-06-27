class ApplicationController < Grape::API
  version 'v1', using: :path
  format :json

  mount AcoesController
end
