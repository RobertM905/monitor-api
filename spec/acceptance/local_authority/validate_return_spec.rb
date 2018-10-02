# frozen_string_literal: true

require 'rspec'
require_relative '../shared_context/use_case_factory'

describe 'Validates HIF return' do
  include_context 'use case factory'

  context 'Invalid HIF return' do
    # percent complete set to > 100
    let(:project_base_return_invalid) do
      JSON.parse(
        File.open("#{__dir__}/../../fixtures/base_return.json").read,
        symbolize_names: true
      )
    end

    it 'should return invalid if fails validation' do
      p project_base_return_invalid
      valid_return = get_use_case(:validate_return).execute(type: 'hif', return_data: project_base_return_invalid)
      expect(valid_return[:valid]).to eq(false)
      expect(valid_return[:invalid_paths]).to eq([[:infrastructures, 0, :planning, :outlinePlanning]])
      expect(valid_return[:pretty_invalid_paths]).to eq([['HIF Project', 'Infrastructures', 'Infrastructure 1', 'Planning', 'Outline Planning']])
    end
  end
end
