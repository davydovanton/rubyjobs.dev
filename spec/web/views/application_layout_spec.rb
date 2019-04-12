# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Web::Views::ApplicationLayout, type: :view do
  let(:layout)   { Web::Views::ApplicationLayout.new(template, {}) }
  let(:template) { Hanami::View::Template.new('apps/web/templates/application.html.slim') }
  let(:rendered) { layout.render }

  describe '#company_text' do
    subject { layout.company_text(vacancy).to_s }

    let(:vacancy) { Vacancy.new(contact: contact) }

    context 'when contact contains site' do
      let(:contact) { Contact.new(company: 'rubyjobs.dev', site: 'rubyjobs.dev') }

      it { expect(subject).to eq('<a href="rubyjobs.dev">rubyjobs.dev</a>') }
    end

    context 'when contact does not contain site' do
      let(:contact) { Contact.new(company: 'rubyjobs.dev') }

      it { expect(subject).to eq('rubyjobs.dev') }
    end
  end
end
