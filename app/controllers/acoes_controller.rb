class AcoesController < Grape::API
  helpers do
    def acao
      @acao ||= Acoes.find(params[:id])
    end

    def build_acao(acao_params)
      @acao ||= Acoes.new(acao_params)
    end

    def acao_params
      { codigo: params[:codigo], status: params[:status] }
    end
  end

  resource :acoes do
    get do
      acoes = Acoes.all

      present acoes, with: AcoesPresenter
    end

    get ':id' do
      present acao, with: AcoesPresenter
    end

    post do
      build_acao(acao_params)
      if acao.save
        present acao, with: AcoesPresenter
      else
        error!("Invalid acao", 400)
      end
    end

    put ':id' do
      if acao.update(acao_params)
        present acao, with: AcoesPresenter
      else
        error!("Invalid acao attributes", 400)
      end
    end

    delete ':id' do
      acao.destroy
      present acao, with: AcoesPresenter
    end
  end
end
