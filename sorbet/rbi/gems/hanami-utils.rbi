# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: strong
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/hanami-utils/all/hanami-utils.rbi
#
# hanami-utils-1.3.1
module Hanami
end
module Hanami::Utils
  def self.for_each_file_in(directory, &blk); end
  def self.jruby?; end
  def self.reload!(directory); end
  def self.require!(directory); end
  def self.rubinius?; end
end
module Hanami::Utils::FileList
  def self.[](*args); end
end
module Hanami::Utils::Duplicable
  def self.dup(value, &blk); end
end
module Hanami::Utils::ClassAttribute
  def self.included(base); end
end
module Hanami::Utils::ClassAttribute::ClassMethods
  def class_attribute(*attributes); end
  def class_attributes; end
  def inherited(subclass); end
end
class Hanami::Utils::Blank
  def self.blank?(object); end
  def self.filled?(object); end
end
module Hanami::Utils::Inflector
  def self.add_to_inflecto(singular, plural); end
  def self.exception(singular, plural); end
  def self.inflections(&blk); end
  def self.pluralize(string); end
  def self.plurals; end
  def self.plurals=(arg0); end
  def self.singularize(string); end
  def self.singulars; end
  def self.singulars=(arg0); end
  def self.uncountable(*words); end
  extend Hanami::Utils::ClassAttribute::ClassMethods
  include Hanami::Utils::ClassAttribute
end
class Hanami::Utils::Inflector::IrregularRules
  def ===(other); end
  def add(key, value); end
  def apply(string); end
  def initialize(rules); end
end
class Hanami::Utils::String
  def ==(other); end
  def capitalize; end
  def classify; end
  def dasherize; end
  def demodulize; end
  def eql?(other); end
  def gsub(pattern, replacement = nil, &blk); end
  def hash; end
  def initialize(string); end
  def method_missing(method_name, *args, &blk); end
  def namespace; end
  def pluralize; end
  def respond_to_missing?(method_name, include_private = nil); end
  def rsub(pattern, replacement); end
  def scan(pattern, &blk); end
  def self.bind(value, binding, fun); end
  def self.capitalize(input); end
  def self.classify(input); end
  def self.dasherize(input); end
  def self.demodulize(input); end
  def self.namespace(input); end
  def self.pluralize(input); end
  def self.rsub(input, pattern, replacement); end
  def self.singularize(input); end
  def self.titleize(input); end
  def self.transform(input, *transformations); end
  def self.underscore(input); end
  def singularize; end
  def split(pattern, limit = nil); end
  def titleize; end
  def to_s; end
  def to_str; end
  def tokenize; end
  def underscore; end
  extend Transproc::Composer
  extend Transproc::Registry
end
class Hanami::Utils::Deprecation
  def caller_index; end
  def initialize(message); end
end
class Hanami::Utils::Class
  def self.load!(name, namespace = nil); end
  def self.load(name, namespace = nil); end
  def self.load_from_pattern!(pattern, namespace = nil); end
  def self.tokenize(pattern); end
end
class Hanami::Utils::Hash
  def ==(other); end
  def [](key); end
  def []=(key, value); end
  def deep_dup; end
  def deep_symbolize!; end
  def delete(key); end
  def eql?(other); end
  def hash; end
  def initialize(hash = nil, &blk); end
  def inspect; end
  def keys; end
  def method_missing(method_name, *args, &blk); end
  def respond_to_missing?(method_name, include_private = nil); end
  def self.deep_dup(input); end
  def self.deep_serialize(input); end
  def self.deep_stringify(input); end
  def self.deep_symbolize(input); end
  def self.stringify(input); end
  def self.symbolize(input); end
  def stringify!; end
  def symbolize!; end
  def to_a; end
  def to_h; end
  def to_hash; end
  extend Transproc::Registry
end
class Boolean
end
module Hanami::Utils::Kernel
  def self.Array(arg); end
  def self.BigDecimal(arg, precision = nil); end
  def self.Boolean(arg); end
  def self.Date(arg); end
  def self.DateTime(arg); end
  def self.Float(arg); end
  def self.Hash(arg); end
  def self.Integer(arg); end
  def self.Pathname(arg); end
  def self.Set(arg); end
  def self.String(arg); end
  def self.Symbol(arg); end
  def self.Time(arg); end
  def self.inspect_type_error(arg); end
  def self.numeric?(arg); end
end
class Hanami::Utils::PathPrefix < Hanami::Utils::String
  def absolute!; end
  def absolute?; end
  def initialize(string = nil, separator = nil); end
  def join(*strings); end
  def relative!; end
  def relative_join(strings, separator = nil); end
  def separator; end
end
class Hanami::Utils::LoadPaths
  def <<(*paths); end
  def ==(other); end
  def each; end
  def freeze; end
  def initialize(*paths); end
  def initialize_copy(original); end
  def paths; end
  def push(*paths); end
  def realpath(path); end
end
module Hanami::Utils::Escape
  def self.encode(input); end
  def self.encode_char(char, safe_chars = nil); end
  def self.hex_for_non_alphanumeric_code(input); end
  def self.html(input); end
  def self.html_attribute(input); end
  def self.url(input, schemes = nil); end
end
class Hanami::Utils::Escape::SafeString < String
  def encode(*args); end
  def to_s; end
end
class Hanami::Utils::BasicObject < BasicObject
  def __inspect; end
  def class; end
  def inspect; end
  def object_id; end
  def pretty_print(printer); end
  def respond_to?(method_name, include_all = nil); end
  def respond_to_missing?(_method_name, _include_all); end
end
module Hanami::Utils::Callbacks
end
class Hanami::Utils::Callbacks::Chain
  def append(*callbacks, &block); end
  def callables(callbacks, block); end
  def freeze; end
  def initialize; end
  def prepend(*callbacks, &block); end
  def run(context, *args); end
end
class Hanami::Utils::Callbacks::Factory
  def self.fabricate(callback); end
end
class Hanami::Utils::Callbacks::Callback
  def call(context, *args); end
  def callback; end
  def initialize(callback); end
end
class Hanami::Utils::Callbacks::MethodCallback < Hanami::Utils::Callbacks::Callback
  def call(context, *args); end
  def eql?(other); end
  def hash; end
end
class Hanami::Utils::IO
  def self.silence_warnings; end
end
module Hanami::Utils::Files
  def self._inject_line_after(path, target, contents, finder); end
  def self._inject_line_before(path, target, contents, finder); end
  def self.append(path, contents); end
  def self.cp(source, destination); end
  def self.delete(path); end
  def self.delete_directory(path); end
  def self.directory?(path); end
  def self.exist?(path); end
  def self.index(content, path, target); end
  def self.inject_line_after(path, target, contents); end
  def self.inject_line_after_last(path, target, contents); end
  def self.inject_line_before(path, target, contents); end
  def self.inject_line_before_last(path, target, contents); end
  def self.line_number(content, target, finder: nil); end
  def self.match?(content, target); end
  def self.mkdir(path); end
  def self.mkdir_p(path); end
  def self.open(path, mode, *content); end
  def self.remove_block(path, target); end
  def self.remove_line(path, target); end
  def self.replace_first_line(path, target, replacement); end
  def self.replace_last_line(path, target, replacement); end
  def self.rewrite(path, *content); end
  def self.rindex(content, path, target); end
  def self.touch(path); end
  def self.unshift(path, line); end
  def self.write(path, *content); end
end
module Hanami::Utils::Json
  def self.generate(object); end
  def self.parse(payload); end
end
class Hanami::Utils::Json::MultiJsonAdapter
  def generate(object); end
  def parse(payload); end
end
module Hanami::Utils::QueryString
  def self.call(input); end
end
class Hanami::Logger < Logger
  def _application_name_from_namespace; end
  def _default_application_name; end
  def _level(level); end
  def application_name; end
  def application_name=(arg0); end
  def close; end
  def initialize(application_name = nil, *args, stream: nil, level: nil, formatter: nil, filter: nil, colorizer: nil); end
  def level=(value); end
  def lookup_colorizer(colorizer); end
  def self.level(level); end
  def tty?; end
end
class Hanami::Logger::Filter
  def _actual_keys(hash, keys); end
  def _build_path(base, key); end
  def _filtered_keys(hash); end
  def _key_paths(hash, base = nil); end
  def call(hash); end
  def filters; end
  def initialize(filters = nil); end
end
module Hanami::Utils::ShellColor
  def self.call(input, color:); end
  def self.color_code(code); end
end
class Hanami::Utils::ShellColor::UnknownColorCodeError < StandardError
  def initialize(code); end
end
class Hanami::Logger::NullColorizer
  def call(app, severity, datetime, _progname); end
end
class Hanami::Logger::Colorizer < Hanami::Logger::NullColorizer
  def app(input); end
  def call(app, severity, datetime, _progname); end
  def colorize(message, color:); end
  def colors; end
  def datetime(input); end
  def initialize(colors: nil); end
  def severity(input); end
end
class Hanami::Logger::Formatter < Logger::Formatter
  def _format(hash); end
  def _format_error(hash); end
  def _format_message(hash); end
  def _line_front_matter(*args); end
  def _message_hash(message); end
  def application_name; end
  def application_name=(arg0); end
  def call(severity, time, progname, msg); end
  def colorizer=(arg0); end
  def filter=(arg0); end
  def self._formatter_instance(formatter); end
  def self.eligible?(name); end
  def self.fabricate(formatter, application_name, filters, colorizer); end
  def self.inherited(subclass); end
  def self.subclasses; end
  def self.subclasses=(arg0); end
  extend Hanami::Utils::ClassAttribute::ClassMethods
  include Hanami::Utils::ClassAttribute
end
class Hanami::Logger::JSONFormatter < Hanami::Logger::Formatter
  def _format(hash); end
  def colorizer=(*arg0); end
  def self.eligible?(name); end
  def self.subclasses; end
  def self.subclasses=(arg0); end
end