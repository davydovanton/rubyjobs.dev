# frozen_string_literal: true

RSpec.describe Web::Views::Vacancies::Index, type: :view do
  let(:params) { Hash[] }
  let(:search_query) { Hash[] }
  let(:exposures) { Hash[format: :html, flash: {}, params: params, vacancies: [], search_query: search_query] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/vacancies/index.html.slim') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #format' do
    expect(view.format).to eq exposures.fetch(:format)
  end

  describe 'remote radiobuttons' do
    let(:rendered) { without_indentation(view.render) }

    before { allow(view).to receive(:pagination) }

    it do
      expect(rendered).to include without_indentation <<~HTML
        <div class="btn-group btn-group-toggle">
        <a class="btn btn-light active"><span>Любые</span></a>
        <a class="btn btn-light" href="/?query=remote%3Atrue"><span>Удаленные</span></a>
        <a class="btn btn-light" href="/?query=remote%3Afalse"><span>В офисе</span></a>
        </div>
      HTML
    end

    context 'when remote is true' do
      let(:search_query) { Hash[remote: 'true'] }

      it do
        expect(rendered).to include without_indentation <<~HTML
          <div class="btn-group btn-group-toggle">
          <a class="btn btn-light" href="/"><span>Любые</span></a>
          <a class="btn btn-light active"><span>Удаленные</span></a>
          <a class="btn btn-light" href="/?query=remote%3Afalse"><span>В офисе</span></a>
          </div>
        HTML
      end
    end

    context 'when remote is false' do
      let(:search_query) { Hash[remote: 'false'] }

      it do
        expect(rendered).to include without_indentation <<~HTML
          <div class="btn-group btn-group-toggle">
          <a class="btn btn-light" href="/"><span>Любые</span></a>
          <a class="btn btn-light" href="/?query=remote%3Atrue"><span>Удаленные</span></a>
          <a class="btn btn-light active"><span>В офисе</span></a>
          </div>
        HTML
      end
    end

    context 'when remote is not valid' do
      let(:search_query) { Hash[remote: 'foo'] }

      it do
        expect(rendered).to include without_indentation <<~HTML
          <div class="btn-group btn-group-toggle">
          <a class="btn btn-light active"><span>Любые</span></a>
          <a class="btn btn-light" href="/?query=remote%3Atrue"><span>Удаленные</span></a>
          <a class="btn btn-light" href="/?query=remote%3Afalse"><span>В офисе</span></a>
          </div>
        HTML
      end
    end
  end

  def without_indentation(string)
    string.strip.gsub("\n", '')
  end
end
