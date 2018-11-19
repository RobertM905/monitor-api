# frozen_string_literal: true

require_relative '../shared_context/dependency_factory'

describe 'Interacting with a HIF Return from the UI' do
  include_context 'dependency factory'

  before do
    ENV['OUTPUTS_FORECAST_TAB'] = 'Yes'
    ENV['CONFIRMATION_TAB'] = 'Yes'
    ENV['S151_TAB'] = 'Yes'
    ENV['RM_MONTHLY_CATCHUP_TAB'] = 'Yes'
    ENV['OUTPUTS_ACTUALS_TAB'] = 'Yes'
    project_id
  end

  after do
    ENV['OUTPUTS_FORECAST_TAB'] = nil
    ENV['CONFIRMATION_TAB'] = nil
    ENV['S151_TAB'] = nil
    ENV['RM_MONTHLY_CATCHUP_TAB'] = nil
    ENV['OUTPUTS_ACTUALS_TAB'] = nil
  end

  let(:project_id) { create_project }
  let(:hif_baseline) do
    JSON.parse(
      File.open("#{__dir__}/../../fixtures/hif_baseline_ui.json").read,
      symbolize_names: true
    )
  end

  let(:hif_get_return) do
    JSON.parse(
      File.open("#{__dir__}/../../fixtures/hif_saved_base_return.json").read,
      symbolize_names: true
    )
  end

  let(:expected_updated_return) do
    JSON.parse(
      File.open("#{__dir__}/../../fixtures/hif_updated_return.json").read,
      symbolize_names: true
    )
  end

  let(:full_return_data) do
    JSON.parse(
      File.open("#{__dir__}/../../fixtures/hif_return_ui.json").read,
      symbolize_names: true
    )
  end

  let(:full_return_data_after_calcs) do
    JSON.parse(
      File.open("#{__dir__}/../../fixtures/hif_return_ui_after_calcs.json").read,
      symbolize_names: true
    )
  end


  def create_project
    dependency_factory.get_use_case(:ui_create_project).execute(
      type: 'hif',
      name: 'Cat Infrastructures',
      baseline: hif_baseline
    )[:id]
  end

  context 'Creating a return' do
    it 'Allows you to create and view a return' do
      base_return = get_use_case(:ui_get_base_return).execute(project_id: project_id)[:base_return]

      return_data = base_return[:data].dup
      return_id = dependency_factory.get_use_case(:ui_create_return).execute(project_id: project_id, data: return_data)[:id]
      return_data[:infrastructures][0][:planning][:outlinePlanning][:planningSubmitted][:status] = 'Delayed'
      return_data[:infrastructures][0][:planning][:outlinePlanning][:planningSubmitted][:reason] = 'Distracted by kittens'
      return_data[:s151][:claimSummary][:hifTotalFundingRequest] = '10000'
      return_data[:s151Confirmation][:hifFunding][:hifTotalFundingRequest] = '10000'
      dependency_factory.get_use_case(:ui_update_return).execute(return_id: return_id, return_data: return_data)

      created_return = dependency_factory.get_use_case(:ui_get_return).execute(id: return_id)[:updates].last
      expect(created_return[:s151Confirmation]).to eq(expected_updated_return[:s151Confirmation])

      expect(created_return).to eq(expected_updated_return)
    end

    it 'Allows you to create a return with all the data in' do
      return_id = dependency_factory.get_use_case(:ui_create_return).execute(project_id: project_id, data: full_return_data)[:id]
      created_return = dependency_factory.get_use_case(:ui_get_return).execute(id: return_id)[:updates].last

      expect(created_return[:infrastructures][0][:planning]).to eq(full_return_data_after_calcs[:infrastructures][0][:planning])
    end

    it 'Allows you to view multiple created returns' do
      base_return = get_use_case(:ui_get_base_return).execute(project_id: project_id)[:base_return]
      return_data = base_return[:data].dup

      dependency_factory.get_use_case(:ui_create_return).execute(project_id: project_id, data: return_data)[:id]
      dependency_factory.get_use_case(:ui_create_return).execute(project_id: project_id, data: return_data)[:id]

      created_returns = dependency_factory.get_use_case(:ui_get_returns).execute(project_id: project_id)[:returns]

      created_return_one = created_returns[0][:updates][0]
      created_return_two = created_returns[1][:updates][0]

      expect(created_return_one).to eq(hif_get_return)
      expect(created_return_two).to eq(hif_get_return)
    end
  end
end
