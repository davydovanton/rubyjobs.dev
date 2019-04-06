# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Web::Views::ApplicationLayout, type: :view do
  let(:layout)   { Web::Views::ApplicationLayout.new(template, {}) }
  let(:template) { Hanami::View::Template.new('apps/web/templates/application.html.slim') }
  let(:rendered) { layout.render }
end
