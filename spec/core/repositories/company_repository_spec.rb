# frozen_string_literal: true

RSpec.describe CompanyRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '#all_with_reviews' do
    subject { repo.all_with_reviews }

    before do
      id = Fabricate(:company, name: 'Google').id
      Fabricate(:review, company_id: id)
    end

    it 'returns list of companies with reviews' do
      expect(subject.size).to eq(1)
      expect(subject.first).to be_a(Company)

      expect(subject.first.reviews.size).to eq(1)
      expect(subject.first.reviews.first).to be_a(Review)
    end
  end

  describe '#already_exist?' do
    subject { repo.already_exist?(company) }

    before { Fabricate(:company, name: 'Google') }

    context 'when name contain other case' do
      let(:company) { Company.new(name: 'googLe') }

      it { expect(subject).to be true }
    end

    context 'when name is absolute same' do
      let(:company) { Company.new(name: 'Google') }

      it { expect(subject).to be true }
    end

    context 'when name contains space' do
      let(:company) { Company.new(name: 'g oogle') }

      it { expect(subject).to be true }
    end

    context 'when name contains trim chars' do
      let(:company) { Company.new(name: ' google ') }

      it { expect(subject).to be true }
    end

    context 'when name is different' do
      let(:company) { Company.new(name: 'other') }

      it { expect(subject).to be false }
    end
  end

  describe '#update_statistic' do
    let(:company) do
      Fabricate(
        :company,
        ratings: {
          salary_value: 3.0,
          office: 3.0,
          working_time: 3.0,
          project_interest: 3.0,
          atmosphere: 3.0,
          personal_growth: 3.0,
          modern_technologies: 3.0,
          management_level: 3.0,
          team_level: 3.0
        },
        rating_total: 3.0
      )
    end

    let(:new_ratings) do
      {
        salary_value: 5.0,
        office: 0.0,
        working_time: 2.0,
        project_interest: 4.0,
        atmosphere: 3.0,
        personal_growth: 5.0,
        modern_technologies: 1.0,
        management_level: 2.0,
        team_level: 1.0
      }
    end

    it 'updates cached ratings values and rating_total value' do
      repo.update_statistic(company.id, new_ratings)
      updated_company = repo.find(company.id)

      expect(updated_company.ratings.to_h).to eq({
                                                   'salary_value' => 4.0,
                                                   'office' => 3.0,
                                                   'working_time' => 2.5,
                                                   'project_interest' => 3.5,
                                                   'atmosphere' => 3.0,
                                                   'personal_growth' => 4.0,
                                                   'modern_technologies' => 2.0,
                                                   'management_level' => 2.5,
                                                   'team_level' => 2.0
                                                 })

      expect(updated_company.rating_total).to eq(2.9)
    end

    context 'when company has zero ratings' do
      let(:company) { Fabricate(:company) }

      let(:new_ratings) do
        {
          salary_value: 5.0,
          office: 1.0,
          working_time: 2.0,
          project_interest: 4.0,
          atmosphere: 3.0,
          personal_growth: 5.0,
          modern_technologies: 1.0,
          management_level: 2.0,
          team_level: 1.0
        }
      end

      it 'updates cached ratings values and rating_total value' do
        repo.update_statistic(company.id, new_ratings)
        updated_company = repo.find(company.id)

        expect(updated_company.ratings.to_h).to eq({
                                                     'salary_value' => 5.0,
                                                     'office' => 1.0,
                                                     'working_time' => 2.0,
                                                     'project_interest' => 4.0,
                                                     'atmosphere' => 3.0,
                                                     'personal_growth' => 5.0,
                                                     'modern_technologies' => 1.0,
                                                     'management_level' => 2.0,
                                                     'team_level' => 1.0
                                                   })

        expect(updated_company.rating_total).to eq(2.7)
      end
    end
  end
end
