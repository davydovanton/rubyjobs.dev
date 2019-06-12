# frozen_string_literal: true

require 'strscan'

module Libs
  class SearchQueryParser
    OPTION_TOKEN = /\w+:\w+/.freeze
    SPASE_TOKEN = /\s/.freeze

    SEPARATOR_CHAR = ':'

    def call(query)
      scanner = StringScanner.new(query.to_s)
      options = scan_options(scanner)
      text = scanner.scan(/.+/)
      { text: text, **options }
    end

    private

    def scan_options(scanner, options = {})
      scanner.scan(SPASE_TOKEN)

      while token = scanner.scan(OPTION_TOKEN) # rubocop:disable Lint/AssignmentInCondition
        process_option_toker(options, token)
        scanner.scan(SPASE_TOKEN)
      end

      options
    end

    def process_option_toker(options, token)
      node, value = token.split(SEPARATOR_CHAR)

      options[node.to_sym] = options[node.to_sym] ? Array(options[node.to_sym]) << value : value
    end
  end
end
