require 'active_support/core_ext/string/filters'

module Brandcash
  module Responses
    class Ticket < Base
      def goods
        @goods ||= begin

          divider = 100.0
          items = body[:items].map(&:dup)
          items.map do |good|
            good[:name] = good[:name].squish
            good[:price] = (good[:price].to_f / divider)
            good[:sum] = (good[:sum].to_f / divider)
            good
          end
        end
      end

      def inn
        body.fetch(:userInn, nil)
      end

      def ticket
        body
      end

      private

      def items_blank?
        ticket.fetch(:items, [])
      end
    end
  end
end
