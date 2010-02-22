# encoding: utf-8

module ArcServer
  module REST
    class MapServer
      attr_reader :url

      def initialize(url)
        @url = url
      end

      def query(layerId, opts = {})
        
        query ={
          :f          => opts[:f]     || :json,
          :where      => opts[:where],
          :returnGeometry => opts[:returnGeometry] || false,
          :outFields  =>  opts[:outFields]
        }
        HTTParty.get("#{url}/#{layerId}/query", :query => query)
      end

      def export(opts = {})
        query = {
          :bbox        => opts[:bbox],
          :f           => opts[:f]           || :image,
          :format      => opts[:format]      || :png24,
          :transparent => opts[:transparent] || true,
          :size        => opts[:size],
          :dpi         => opts[:dpi]
        }
        HTTParty.get("#{url}/export", :query => query)
      end
    end
  end
end