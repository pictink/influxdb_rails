module InfluxDB
  module Rails
    class Rack
      def initialize(app)
        @app = app
      end

      def call(env)
        dup._call(env)
      end

      def _call(env)
        begin
          response = @app.call(env)
        rescue => e
          InfluxDB::Rails.transmit_unless_ignorable(e, env)
          raise(e)
        end

        response
      end
    end
  end
end
