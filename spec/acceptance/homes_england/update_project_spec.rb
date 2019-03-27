require 'rspec'
require 'timecop'
require_relative '../shared_context/dependency_factory'

describe 'Updating a HIF Project' do
  include_context 'dependency factory'

  let(:project_baseline) do
    {
      summary: {
        project_name: 'Cats Protection League',
        description: 'A new headquarters for all the Cats',
        lead_authority: 'Made Tech'
      },
      infrastructure: {
        type: 'Cat Bathroom',
        description: 'Bathroom for Cats',
        completion_date: '2018-12-25'
      },
      financial: {
        date: '2017-12-25',
        funded_through_HIF: true
      }
    }
  end

  let(:project_id) do
    get_use_case(:create_new_project).execute(
      name: 'cat project',
      type: 'hif',
      baseline: project_baseline,
      bid_id: 'HIF/MV/5'
    )[:id]
  end

  it 'should update a project' do
    success = get_use_case(:update_project).execute(project_id: project_id, project_data: { cats: 'meow' }, timestamp: 123)

    expect(success[:successful]).to eq(true)

    updated_project = get_use_case(:find_project).execute(id: project_id)

    expect(updated_project[:type]).to eq('hif')
    expect(updated_project[:data][:cats]).to eq('meow')
  end

  context 'updating an old version of the project data' do
    it 'wont overwrite the more recent version of the project data' do
      time_now = Time.now
      Timecop.freeze(time_now)

      get_use_case(:update_project).execute(project_id: project_id, project_data: { cats: 'meow' }, timestamp: time_now.to_i)
      updated_project = get_use_case(:find_project).execute(id: project_id)

      expect(updated_project[:timestamp]).to eq(time_now.to_i)

      response = get_use_case(:update_project).execute(project_id: project_id, project_data: { cats: 'meow' }, timestamp: time_now.to_i - 2000)

      expect(response).to eq({successful: false, errors: [:incorrect_timestamp], timestamp: time_now.to_i - 2000})
      expect(updated_project[:data]).to eq({ cats: 'meow'})

      Timecop.return
    end
  end

  context 'updating the project admin details' do
    it 'updates the details for the project' do
      admin_data = {
        contact1: 'name',
        understudy: 'mike',
        email: 'mike@name.com',
        telephone: '23101'
      }
  
      get_use_case(:update_project_admin).execute(project_id: project_id, data: admin_data, timestamp: 0)
  
      updated_project = get_use_case(:find_project).execute(id: project_id)
  
      expect(updated_project[:admin_data]).to eq(admin_data)      
    end
  end
end
