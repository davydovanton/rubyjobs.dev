# frozen_string_literal: true

Container.boot(:logger) do |container|
  init do
    if ENV['LOGGER_JSON_FORMATTER']
      SemanticLogger.add_appender(io: logger_io, formatter: :json)
    else
      SemanticLogger.add_appender(io: logger_io)
    end

    SemanticLogger.default_level = Core::Types::LoggerLevel[ENV['LOGGER_LEVEL']]
    container.register(:logger, SemanticLogger['PricesAPI'])

    if Hanami.env == :production
      container[:logger].info do
        "started with #{ENV.to_hash.sort.map { |(name, value)| "#{name}=#{value}" }.join(', ')}"
      end
    end
  end

  # detect default logger IO output
  def logger_io
    Hanami.env == 'test' ? StringIO.new : STDOUT
  end
end
