# frozen_string_literal: true

require 'rspec'
require_relative '../shared_context/dependency_factory'

describe 'Submitting a completed draft project' do
  include_context 'dependency factory'
  context 'Whilst status is LA Draft' do
    it 'Changes the status to submitted' do
      project_baseline = {
        summary: {
          project_name: '',
          description: '',
          lead_authority: ''
        },
        infrastructure: {
          type: '',
          description: '',
          completion_date: '',
          planning: {
            submission_estimated: ''
          }
        },
        financial: {
          total_amount_estimated: ''
        }
      }
      response = get_use_case(:create_new_project).execute(
        type: 'hif', baseline: project_baseline
      )
      get_use_case(:submit_project).execute(project_id: response[:id])
      get_use_case(:submit_project).execute(project_id: response[:id])
      submitted_project = get_use_case(:find_project).execute(id: response[:id])

      expect(submitted_project[:status]).to eq('Submitted')
    end
  end

  context 'Whilst status is Draft' do
    it 'Changes the status to LA Draft' do
      project_baseline = {
        summary: {
          project_name: '',
          description: '',
          lead_authority: ''
        },
        infrastructure: {
          type: '',
          description: '',
          completion_date: '',
          planning: {
            submission_estimated: ''
          }
        },
        financial: {
          total_amount_estimated: ''
        }
      }
      response = get_use_case(:create_new_project).execute(
        type: 'hif', baseline: project_baseline
      )
      get_use_case(:submit_project).execute(project_id: response[:id])
      submitted_project = get_use_case(:find_project).execute(id: response[:id])

      expect(submitted_project[:status]).to eq('LA Draft')
    end
  end
end
