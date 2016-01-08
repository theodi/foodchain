module Foodchain
  module Inspections
    class Import

      extend Foodchain::Helpers

      def self.all recipient
        inspections.each do |i|
          send_inspection(recipient, i)
        end
      end

      def self.latest last_date, recipient
        inspections.each do |i|
          send_inspection(recipient, i) unless DateTime.parse(i[:date]) <= last_date
        end
      end

      def self.send_inspection recipient, inspection
        data = hexify inspection
        client.send_asset_with_data(recipient, 0, data)
      end

      def self.client
        @@client ||= Multichain::Client.new
      end

      def self.inspections
        all_inspections = []

        (1..total).each do |i|
          inspections = get(template % {page: i})

          inspections['establishments'].each do |e|
            all_inspections << {
              id: e['FHRSID'],
              date: e['RatingDate'],
              rating: e['RatingValue']
            }
          end
        end

        all_inspections
      end

      def self.template
        "http://api.ratings.food.gov.uk/Establishments/basic/%{page}/1000"
      end

      def self.total
        meta = get(template % {page: 1})
        meta['meta']['totalPages'].to_i
      end

    end
  end
end
