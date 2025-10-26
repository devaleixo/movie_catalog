class GeminiService
  API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent"

  def initialize
    @api_key = ENV['GEMINI_API_KEY']
    raise "GEMINI_API_KEY não configurada" if @api_key.blank?
  end

  def fetch_movie_data(movie_title)
    prompt = build_prompt(movie_title)
    response = make_request(prompt)
    parse_response(response)
  rescue => e
    { error: "Erro ao buscar dados: #{e.message}" }
  end

  private

  def build_prompt(movie_title)
    <<~PROMPT
      Forneça informações detalhadas sobre o filme "#{movie_title}" no formato JSON exato abaixo.
      Se o filme não existir, retorne um JSON com o campo "error".
      
      Formato esperado:
      {
        "title": "Título completo do filme",
        "synopsis": "Sinopse detalhada do filme (2-3 frases)",
        "release_year": ano_como_número,
        "duration": duração_em_minutos_como_número,
        "director": "Nome do diretor",
        "rating": avaliação_de_0_a_5_como_número_decimal,
        "categories": ["Gênero1", "Gênero2"]
      }

      Retorne APENAS o JSON, sem texto adicional.
    PROMPT
  end

  def make_request(prompt)
    conn = Faraday.new(url: API_URL) do |f|
      f.request :json
      f.response :json
      f.adapter Faraday.default_adapter
    end

    response = conn.post do |req|
      req.params['key'] = @api_key
      req.headers['Content-Type'] = 'application/json'
      req.body = {
        contents: [{
          parts: [{
            text: prompt
          }]
        }]
      }
    end

    unless response.success?
      raise "Erro na API: #{response.status} - #{response.body}"
    end

    response.body
  end

  def parse_response(response)
    # Extrair o texto da resposta do Gemini
    text = response.dig('candidates', 0, 'content', 'parts', 0, 'text')
    
    return { error: "Resposta vazia da API" } if text.blank?

    # Remover possíveis markdown code blocks
    text = text.gsub(/```json\n?/, '').gsub(/```\n?/, '').strip

    # Parse do JSON
    movie_data = JSON.parse(text)

    # Verificar se há erro
    return { error: movie_data['error'] } if movie_data['error']

    # Normalizar os dados
    {
      title: movie_data['title'],
      synopsis: movie_data['synopsis'],
      release_year: movie_data['release_year']&.to_i,
      duration: movie_data['duration']&.to_i,
      director: movie_data['director'],
      rating: movie_data['rating']&.to_f,
      categories: movie_data['categories'] || []
    }
  rescue JSON::ParserError => e
    { error: "Erro ao processar resposta: #{e.message}" }
  end
end
