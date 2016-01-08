module Foodchain
  module Helpers

    def hexify inspection
      inspection.values.join('|').each_byte.map { |b| b.to_s(16) }.join
    end

    def dehexify hex
      result = hex.scan(/../).map { |x| x.hex.chr }.join.split('|')
      {
        id: result[0],
        date: result[1],
        rating: result[2]
      }
    end

    def get url
      HTTParty.get(url, headers: {
          'Content-Type' => 'application/json',
          'x-api-version' => '2'
      }, format: :json)
    end

  end
end
