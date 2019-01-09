# frozen_string_literal: true

require 'rspec'
require_relative '../shared_context/dependency_factory'

describe 'Performing Return on HIF Project' do
  include_context 'dependency factory'

  def update_return(id:, data:)
    get_use_case(:update_return).execute(return_id: id, data: data[:data])
  end

  def submit_return(id:)
    get_use_case(:submit_return).execute(return_id: id)
  end

  def create_new_return(return_data)
    get_use_case(:create_return).execute(return_data)[:id]
  end

  def expect_return_with_id_to_equal(id:, expected_return:)
    found_return = get_use_case(:get_return).execute(id: id)
    expect(found_return[:data]).to eq(expected_return[:data])
    expect(found_return[:status]).to eq(expected_return[:status])
    expect(found_return[:updates]).to eq(expected_return[:updates])
  end

  def expect_return_to_be_submitted(id:)
    found_return = get_use_case(:get_return).execute(id: id)
    expect(found_return[:status]).to eq('Submitted')
  end

  let(:project_baseline) do
    JSON.parse(
      File.open("#{__dir__}/../../fixtures/hif_baseline_core.json").read,
      symbolize_names: true
    )
  end

  let(:project_id) do
    get_use_case(:create_new_project).execute(
      name: '',
      type: 'hif',
      baseline: project_baseline
    )[:id]
  end

  let(:expected_base_return) do
    JSON.parse(
      File.open("#{__dir__}/../../fixtures/base_return.json").read,
      symbolize_names: true
    )
  end

  let(:expected_second_base_return) do
    JSON.parse(
      File.open("#{__dir__}/../../fixtures/second_base_return.json").read,
      symbolize_names: true
    )
  end

  before do
    ENV['OUTPUTS_FORECAST_TAB'] = 'Yes'
    ENV['CONFIRMATION_TAB'] = 'Yes'
    ENV['S151_TAB'] = 'Yes'
    ENV['RM_MONTHLY_CATCHUP_TAB'] = 'Yes'
    ENV['MR_REVIEW_TAB'] = 'Yes'
    ENV['OUTPUTS_ACTUALS_TAB'] = 'Yes'
    project_id
  end

  after do
    ENV['OUTPUTS_FORECAST_TAB'] = nil
    ENV['CONFIRMATION_TAB'] = nil
    ENV['S151_TAB'] = nil
    ENV['MR_REVIEW_TAB'] = nil
    ENV['OUTPUTS_ACTUALS_TAB'] = nil
  end

  it 'should keep track of Returns' do
    base_return = get_use_case(:get_base_return).execute(project_id: project_id)

    expect(base_return[:base_return][:data]).to eq(expected_base_return)

    initial_return = {
      project_id: project_id,
      data: {
        summary: {
          project_name: 'Cats Protection League',
          description: 'A new headquarters for all the Cats',
          lead_authority: 'Made Tech'
        },
        infrastructures: [
          {
            type: 'Cat Bathroom',
            description: 'Bathroom for Cats',
            completion_date: '2018-12-25',
            planning: {
              submission_estimated: '2018-06-01',
              submission_actual: '2018-07-01',
              submission_delay_reason: 'Planning office was closed for summer',
              planningNotGranted: {
                fieldOne: {
                  varianceCalculations: {
                    varianceAgainstLastReturn: {
                      varianceLastReturnFullPlanningPermissionSubmitted: nil
                    }
                  }
                }
              }
            }
          }
        ],
        financial: {
          total_amount_estimated: '£ 1000000.00',
          total_amount_actual: nil,
          total_amount_changed_reason: nil
        }
      }
    }

    return_id = create_new_return(
      project_id: initial_return[:project_id],
      data: initial_return[:data]
    )

    expected_initial_return = {
      project_id: project_id,
      status: 'Draft',
      updates: [
        initial_return[:data]
      ]
    }

    expect_return_with_id_to_equal(
      id: return_id,
      expected_return: expected_initial_return
    )

    updated_return_data = {
      s151: {
        supportingEvidence: {
          lastQuarterMonthSpend: {
            forecast: "1"
          }
        }
      },
      fundingPackages: {
        fundingStack: [
          {
            currentFundingStackDescription: 'describe',
            fundedThroughHIF: 'Yes',
            totalCost: {
              currentAmount: '34'
            },
            hifSpend: {
              currentAmount: '23'
            },
            public: {
              currentAmount: '23',
              balancesSecured: {
                securedAgainstBaseline: '123'
              },
              amountSecured: '12'
            },
            private: {
              currentAmount: '12',
              balancesSecured: {
                securedAgainstBaseline: '124'
              },
              amountSecured: '13'
            }
          }
        ]
      },
      summary: {
        project_name: 'Dogs Protection League',
        description: 'A new headquarters for all the Dogs',
        lead_authority: 'Made Tech'
      },
      infrastructures: [
        {
          type: 'Dog Bathroom',
          description: 'Bathroom for Dogs',
          completion_date: '2018-12-25',
          planning: {
            submission_estimated: '2018-06-01',
            submission_actual: '2018-07-01',
            submission_delay_reason: 'Planning office was closed for summer',
            planningNotGranted: {
              fieldOne: {
                varianceCalculations: {
                  varianceAgainstLastReturn: {
                    varianceLastReturnFullPlanningPermissionSubmitted: nil
                  }
                }
              }
            }
          }
        }
      ],
      funding: [
        {
          fundingPackages: [
            fundingPackage: {
              overview: {
                hifSpendSinceLastReturn: {
                  hifSpendCurrentReturn: '25565'
                }
              }
            }
          ]
        }
      ],
      financial: {
        total_amount_estimated: '£ 1000000.00',
        total_amount_actual: nil,
        total_amount_changed_reason: nil
      }
    }

    soft_update_return(id: return_id, data: updated_return_data)
    soft_update_return(id: return_id, data: updated_return_data)

    expected_updated_return = {
      project_id: project_id,
      status: 'Draft',
      updates: [
        initial_return[:data],
        updated_return_data,
        updated_return_data
      ]
    }

    expect_return_with_id_to_equal(
      id: return_id,
      expected_return: expected_updated_return
    )

    submit_return(id: return_id)
    expect_return_to_be_submitted(id: return_id)

    # A draft
    create_new_return(
      project_id: initial_return[:project_id],
      data: initial_return[:data]
    )

    second_base_return = get_use_case(:get_base_return).execute(project_id: project_id)

    expect(second_base_return[:base_return][:data]).to eq(expected_second_base_return)
  end

  def soft_update_return(id:, data:)
    get_use_case(:soft_update_return).execute(return_id: id, return_data: data)
  end

  def update_return(id:, data:)
    get_use_case(:update_return).execute(return_id: id, data: data)
  end

  def submit_return(id:)
    get_use_case(:submit_return).execute(return_id: id)
  end
end
