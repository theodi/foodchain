module Foodchain
  module Inspections
    class Import

      extend Foodchain::Helpers

      def self.all recipient
        (1..total).each do |n|
          inspections(n).each { |i| send_inspection(recipient, i) }
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

      def self.inspections(page)
        puts "Importing page #{page}"
        inspections = get(template % {page: page})

        inspections['establishments'].map do |e|
          {
            id: e['FHRSID'],
            date: e['RatingDate'],
            rating: e['RatingValue']
          }
        end

        inspections['establishments']
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
