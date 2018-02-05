# frozen_string_literal: true 
 
require_relative '../filter' 
 
module OctocatalogDiff
  module CatalogDiff
    class Filter
      class Charset < OctocatalogDiff::CatalogDiff::Filter
        # @param diff [OctocatalogDiff::API::V1::Diff] Difference
        # @param _options [Hash] Additional options (there are none for this filter)
        # @return [Boolean] true if this should be filtered out, false otherwise
        def filtered?(diff, _options = {})
          # Skip additions or removals - focus only on changes
          return false unless diff.change?
          return false unless diff.old_value.instance_of? String and diff.new_value.instance_of? String
          old_value = diff.old_value
          new_value = diff.new_value
 
          old_value = old_value.force_encoding('ISO-8859-1').encode('UTF-8')
          new_value = new_value.force_encoding('UTF-8')
 
          # Do comparison
          old_value == new_value
        rescue # Rescue everything - if something failed, we aren't sure what's going on, so we'll return false.
          false
        end
      end
    end
  end
end
