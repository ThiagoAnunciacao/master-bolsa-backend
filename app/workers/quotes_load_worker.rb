class QuotesLoadWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  sidekiq_options queue: :quotes_load

  def self.perform()
    require 'open-uri'

    cotacoes = []

		url = "http://www.bmfbovespa.com.br/Pregao-OnLine/ExecutaAcaoCarregarDados.asp?CodDado=Ticker"
		doc = Nokogiri::HTML(open(url))
		cotacoes = doc.at_css("p").text.gsub("v=", "").split("|")

		cotacoes.each do |acao|
			papel = acao.split("@").first
			valor = acao.split("@").last

			status = valor[0].gsub("#", "")
			valor = valor[/([0-9.#-]*)/].gsub("&", "").gsub("#", "")

			acao = Acoes.find_by(:codigo => papel)

			if acao
				acao.valor_atual = valor.to_f
				acao.status = 1
			else
				acao = Acoes.new
				acao.codigo = papel
				acao.valor_atual = valor.to_f
				acao.status = 1
			end

			acao.save
		end
  end
end
