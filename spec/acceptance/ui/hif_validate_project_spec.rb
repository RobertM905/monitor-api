# frozen_string_literal: true

require 'rspec'
require_relative '../shared_context/dependency_factory'

describe 'Validates HIF Project' do
  include_context 'dependency factory'

  context 'Invalid HIF project' do
    let(:invalid_project) do
      JSON.parse(
        File.open("#{__dir__}/../../fixtures/hif_baseline_missing_ui.json").read,
        symbolize_names: true
      )
    end

    it 'should return invalid if fails validation' do
      valid_project = get_use_case(:ui_validate_project).execute(type: 'hif', project_data: invalid_project)
      INVALID_PATH = [
        [:summary, :sitePlans],
        [:infrastructures, 0, :planningStatus, :planningStatus, :fullPlanningStatus, :granted],
        [:costs, 0, :infrastructure, :fundedThroughHif, :descriptionOfFundingStack],
        [:costs, 0, :infrastructure, :baselineCashflows],
        [:recovery, :expectedAmount],
        [:outputs],
        [:rmBaseline]
      ].freeze
      PRETTY_INVALID_PATH = [
        ['HIF Project', 'Project Summary', 'Site Plans'],
        ['HIF Project', 'Infrastructures', 'Infrastructure 1', 'Planning Status', '', 'Full Planning Status', 'Granted?'],
        ['HIF Project', 'Costs', 'Infrastructure 1', 'Cost','', 'If No: Description of Funding Stack'],
        ['HIF Project', 'Costs', 'Infrastructure 1', 'Cost', 'Baseline Cashflow(s)'],
        ['HIF Project', 'Recovery', 'Expected Amount'],
        ['HIF Project', 'Outputs'],
        ['HIF Project', 'RM Baseline']
      ].freeze
      expect(valid_project[:valid]).to eq(false)
      expect(valid_project[:invalid_paths]).to eq(INVALID_PATH)
      expect(valid_project[:pretty_invalid_paths]).to eq(PRETTY_INVALID_PATH)
    end
  end
end
