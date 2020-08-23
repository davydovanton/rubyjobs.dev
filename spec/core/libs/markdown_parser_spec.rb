# frozen_string_literal: true

RSpec.describe Libs::MarkdownParser do
  subject { markdown.call(text) }

  let(:markdown) { described_class.new }

  context 'when text contain heading' do
    let(:text) { '# title' }

    it { expect(subject).to eq %(<h1 id="title">title</h1>\n) }
  end

  context 'when text contain code tag' do
    let(:text) { '`title`' }

    it { expect(subject).to eq %(<p><code>title</code></p>\n) }
  end

  context 'when text contain em tag' do
    let(:text) { '*test*' }

    it { expect(subject).to eq "<p><em>test</em></p>\n" }
  end

  context 'when text contain strong tag' do
    let(:text) { '**test**' }

    it { expect(subject).to eq "<p><strong>test</strong></p>\n" }
  end

  context 'when text contain html tag' do
    let(:text) { '<strong>test</strong>' }

    it { expect(subject).to eq "<p><strong>test</strong></p>\n" }
  end

  context 'when text contain image' do
    let(:text) { '![violin](https://github.com)' }

    it { expect(subject).to eq "<p><img src=\"https://github.com\" alt=\"violin\" /></p>\n" }
  end

  context 'when text contain link tag' do
    let(:text) { '[google.com](https://google.com)' }

    it { expect(subject).to eq %(<p><a href="https://google.com">google.com</a></p>\n) }
  end

  context 'when text contain pure link' do
    let(:text) { 'https://google.com' }

    it { expect(subject).to eq %(<p><a href="https://google.com">https://google.com</a></p>\n) }
  end

  context 'when text contain checkbox tag' do
    let(:text) { '- [ ] checkkbox' }

    # rubocop:disable Layout/LineLength
    it 'replaces checkbox by html tag' do
      expect(subject).to eq %(<ul class="task-list">\n  <li class="task-list-item"><input type="checkbox" class="task-list-item-checkbox" disabled="disabled" />checkkbox</li>\n</ul>\n)
    end
    # rubocop:enable Layout/LineLength
  end

  context 'when text contain checkbox tag' do
    let(:text) { '- [x] checkkbox' }

    # rubocop:disable Layout/LineLength
    it 'replaces checkbox by html tag' do
      expect(subject).to eq %(<ul class="task-list">\n  <li class="task-list-item"><input type="checkbox" class="task-list-item-checkbox" disabled="disabled" checked="checked" />checkkbox</li>\n</ul>\n)
    end
    # rubocop:enable Layout/LineLength
  end
end
