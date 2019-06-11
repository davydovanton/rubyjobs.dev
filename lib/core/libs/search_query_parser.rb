# frozen_string_literal: true

require 'strscan'

module Libs
  class SearchQueryParser
    OPTION_TOKEN = /\w+:\w+/
    SPASE_TOKEN = /\s/

    SEPARATOR_CHAR = ':'.freeze

    def call(query)
      scanner = StringScanner.new(query.to_s)
      options = scan_options(scanner)
      text = scanner.scan(/.+/)
      { text: text, **options }
    end

  private

    def scan_options(scanner, options = {})
      scanner.scan(SPASE_TOKEN)

      while token = scanner.scan(OPTION_TOKEN)
        process_option_toker(options, token)
        scanner.scan(SPASE_TOKEN)
      end

      options
    end

    def process_option_toker(options, token)
      node, value = token.split(SEPARATOR_CHAR)

      if options[node.to_sym]
        options[node.to_sym] = Array(options[node.to_sym]) << value
      else
        options[node.to_sym] = value
      end
    end
  end
end
