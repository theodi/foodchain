module Foodchain
  module Inspections
    describe Import do

      it 'templates a url' do
        expect(described_class.template % {page: 5}).to eq('http://api.ratings.food.gov.uk/Establishments/basic/5/1000')
      end

      it 'gets a url' do
        stub_request(:get, 'http://www.example.com').
          with(headers: {'Content-Type' => 'application/json', 'x-api-version' => '2'}).
          to_return(body: '{"foo": "bar"}')

        expect(described_class.get('http://www.example.com')['foo']).to eq('bar')
      end

      it 'gets all inspections' do
        allow(described_class).to receive(:total) { 5 }

        stub = stub_request(:get, /http:\/\/api.ratings.food.gov.uk\/Establishments\/basic\/[0-9]+\/1000/).
          with(headers: {'Content-Type' => 'application/json', 'x-api-version' => '2'}).
          to_return(body: '{"establishments": [{"FHRSID": 1, "RatingDate": "2016-01-01", "RatingValue": 5}]}')

        inspections = described_class.inspections

        expect(WebMock::RequestRegistry.instance.times_executed(stub.request_pattern)).to eq(5)
        expect(inspections).to eq([
          {
            id: 1,
            date: "2016-01-01",
            rating: 5
          },
          {
            id: 1,
            date: "2016-01-01",
            rating: 5
          },
          {
            id: 1,
            date: "2016-01-01",
            rating: 5
          },
          {
            id: 1,
            date: "2016-01-01",
            rating: 5
          },
          {
            id: 1,
            date: "2016-01-01",
            rating: 5
          }
        ])
      end

      it 'hexifies an inspection' do
        inspection = {
          id: 1,
          date: "2016-01-01",
          rating: 5
        }

        expect(described_class.hexify(inspection)).to eq('317c323031362d30312d30317c35')
      end

      it 'dehexifies an inspection' do
        hex = '317c323031362d30312d30317c35'

        expect(described_class.dehexify(hex)).to eq({
          id: "1",
          date: "2016-01-01",
          rating: "5"
        })
      end

      it 'sends inspections' do
        inspections = {
          id: 1,
          date: "2016-01-01",
          rating: 5
        },
        {
          id: 2,
          date: "2016-01-01",
          rating: 3
        },
        {
          id: 3,
          date: "2016-01-01",
          rating: 2
        },
        {
          id: 4,
          date: "2016-01-01",
          rating: 5
        }

        expect(described_class).to receive(:inspections) { inspections }
        expect_any_instance_of(Multichain::Client).to receive(:send_asset_with_data).exactly(4).times

        described_class.all('foo')
      end

      it 'only sends new data' do
        inspections = {
          id: 1,
          date: "2016-01-01",
          rating: 5
        },
        {
          id: 2,
          date: "2016-01-01",
          rating: 3
        },
        {
          id: 3,
          date: "2016-01-01",
          rating: 2
        },
        {
          id: 4,
          date: "2016-01-01",
          rating: 5
        },
        {
          id: 5,
          date: "2016-02-01",
          rating: 0
        }

        expect(described_class).to receive(:inspections) { inspections }
        expect_any_instance_of(Multichain::Client).to receive(:send_asset_with_data).once

        described_class.latest(DateTime.parse('2016-01-01'), 'foo')
      end

    end
  end
end
