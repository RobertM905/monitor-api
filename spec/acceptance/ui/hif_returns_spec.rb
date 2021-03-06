# frozen_string_literal: true
require_relative '../shared_context/dependency_factory'

describe 'Interacting with a HIF Return from the UI' do
  let(:pcs_domain) { 'https://meow.cat' }
  let(:pcs_secret) { 'Secret' }
  let(:pcs_api_key) do
      Timecop.freeze(Time.now)
      current_time = Time.now.to_i
      thirty_days_in_seconds = 60 * 60 * 24 * 30
      thirty_days_from_now = current_time + thirty_days_in_seconds
      JWT.encode({ exp: thirty_days_from_now }, pcs_secret, 'HS512')
  end

  include_context 'dependency factory'

  before do
    ENV['PCS'] = 'yes'
    ENV['PCS_DOMAIN'] = pcs_domain
    ENV['PCS_SECRET'] = pcs_secret

    ENV['OUTPUTS_FORECAST_TAB'] = 'Yes'
    ENV['CONFIRMATION_TAB'] = 'Yes'
    ENV['S151_TAB'] = 'Yes'
    ENV['RM_MONTHLY_CATCHUP_TAB'] = 'Yes'
    ENV['MR_REVIEW_TAB'] = 'Yes'
    ENV['OUTPUTS_ACTUALS_TAB'] = 'Yes'
    ENV['HIF_RECOVERY_TAB'] = 'Yes'
    project_id
  end

  after do
    ENV['PCS'] = nil
    ENV['PCS_DOMAIN'] = nil
    ENV['PCS_SECRET'] = nil

    ENV['OUTPUTS_FORECAST_TAB'] = nil
    ENV['CONFIRMATION_TAB'] = nil
    ENV['S151_TAB'] = nil
    ENV['RM_MONTHLY_CATCHUP_TAB'] = nil
    ENV['MR_REVIEW_TAB'] = nil
    ENV['OUTPUTS_ACTUALS_TAB'] = nil
    ENV['HIF_RECOVERY_TAB'] = nil
  end

  let(:project_id) { create_project }
  let(:hif_baseline) do
    File.open("#{__dir__}/../../fixtures/hif_baseline_ui.json") do |f|
      JSON.parse(
        f.read,
        symbolize_names: true
      )
    end
  end

  let(:hif_get_return) do
    File.open("#{__dir__}/../../fixtures/hif_saved_base_return_ui.json", 'r') do |f|
      JSON.parse(
        f.read,
        symbolize_names: true
      )
    end
  end

  let(:expected_updated_return) do
    File.open("#{__dir__}/../../fixtures/hif_updated_return_ui.json") do |f|
      JSON.parse(
        f.read,
        symbolize_names: true
      )
    end
  end

  let(:full_return_data) do
    File.open("#{__dir__}/../../fixtures/hif_return_ui.json") do |f|
      JSON.parse(
        f.read,
        symbolize_names: true
      )
    end
  end

  let(:full_return_data_after_calcs) do
    File.open("#{__dir__}/../../fixtures/hif_return_ui_after_calcs.json") do |f|
      JSON.parse(
        f.read,
        symbolize_names: true
      )
    end
  end


  def create_project
    dependency_factory.get_use_case(:ui_create_project).execute(
      type: 'hif',
      name: 'Cat Infrastructures',
      baseline: hif_baseline,
      bid_id: 'HIF/MV/757'
    )[:id]
  end

  context 'Creating a return' do
    it 'Allows you to create and view a return' do
      stub_request(
        :get, "#{pcs_domain}/pcs-api/v1/Projects/HIF%252FMV%252F757"
      ).to_return(
        status: 200,
        body: {
          "projectManager": "Max Stevens",
          "sponsor": "Timothy Turner"
        }.to_json
      ).with(
        headers: {'Authorization' => "Bearer #{pcs_api_key}" }
      )
      stub_request(
        :get, "#{pcs_domain}/pcs-api/v1/Projects/HIF%252FMV%252F757/actuals"
      ).to_return(
        status: 200,
        body: [
          {
            payments: {
              currentYearPayments:
              [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
            }
          }
        ].to_json
      ).with(
        headers: {'Authorization' => "Bearer #{pcs_api_key}" }
      )

      base_return = get_use_case(:ui_get_base_return).execute(project_id: project_id)[:base_return]

      return_data = base_return[:data].dup
      return_data[:infrastructures][0][:planning][:outlinePlanning][:planningSubmitted][:status] = 'Delayed'
      return_data[:infrastructures][0][:planning][:outlinePlanning][:planningSubmitted][:reason] = 'Distracted by kittens'
      return_data[:s151Confirmation][:hifFunding][:hifTotalFundingRequest] = '10000'
      return_data[:s151] = {
        claimSummary: {
          hifTotalFundingRequest: '10000',
          hifSpendToDate: nil,
          AmountOfThisClaim: nil
        }
      }

      return_id = dependency_factory.get_use_case(:ui_create_return).execute(project_id: project_id, data: return_data)[:id]
      dependency_factory.get_use_case(:ui_update_return).execute(return_id: return_id, return_data: return_data)

      created_return = dependency_factory.get_use_case(:ui_get_return).execute(id: return_id)[:updates].last

      expect(created_return[:outputsForecast]).to eq(expected_updated_return[:outputsForecast])
    end

    it 'Allows you to create a return with all the data in' do
      stub_request(
        :get, "#{pcs_domain}/pcs-api/v1/Projects/HIF%252FMV%252F757"
      ).to_return(
        status: 200,
        body: {
          "projectManager": "Max Stevens",
          "sponsor": "Timothy Turner"
        }.to_json
      ).with(
        headers: {'Authorization' => "Bearer #{pcs_api_key}" }
      )
      stub_request(
        :get, "#{pcs_domain}/pcs-api/v1/Projects/HIF%252FMV%252F757/actuals"
      ).to_return(
        status: 200,
        body: [
          {
            payments: {
              currentYearPayments:
              [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
            }
          }
        ].to_json
      ).with(
        headers: {'Authorization' => "Bearer #{pcs_api_key}" }
      )

      return_id = dependency_factory.get_use_case(:ui_create_return).execute(project_id: project_id, data: full_return_data)[:id]
      created_return = dependency_factory.get_use_case(:ui_get_return).execute(id: return_id)[:updates].last

      expect(created_return).to eq(full_return_data_after_calcs)
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
