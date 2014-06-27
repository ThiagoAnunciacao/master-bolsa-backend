class AcoesPresenter < Grape::Entity
  expose(:id)
  expose(:codigo)
  expose(:valor_atual)
  expose(:status)
end
