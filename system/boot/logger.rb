# frozen_string_literal: true

Container.boot(:logger) do |container|
  init do
    use :settings

    if container[:settings].logger_json_formatter
      SemanticLogger.add_appender(io: logger_io, formatter: :json)
    else
      SemanticLogger.add_appender(io: logger_io)
    end

    SemanticLogger.default_level = container[:settings].logger_level
    container.register(:logger, SemanticLogger['RubyJob'])
  end

  # detect default logger IO output
  def logger_io
    Hanami.env == 'test' ? StringIO.new : STDOUT
  end
end
