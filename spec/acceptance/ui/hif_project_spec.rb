# frozen_string_literal: true

require_relative '../shared_context/dependency_factory'

describe 'Interacting with a HIF Project from the UI' do
  include_context 'dependency factory'

  let(:baseline_data) do
    JSON.parse(
      File.open("#{__dir__}/../../fixtures/hif_baseline.json").read,
      symbolize_names: true
    )
  end

  let(:empty_baseline_data) do
    JSON.parse(
      File.open("#{__dir__}/../../fixtures/hif_empty_baseline.json").read,
      symbolize_names: true
    )
  end

  let(:updated_baseline_data) do
    JSON.parse(
      File.open("#{__dir__}/../../fixtures/hif_baseline.json").read,
      symbolize_names: true
    )
  end

  def create_project
    dependency_factory.get_use_case(:ui_create_project).execute(
      type: 'hif',
      name: 'Cat Infrastructures',
      baseline: baseline_data
    )[:id]
  end

  def create_empty_project
    dependency_factory.get_use_case(:ui_create_project).execute(
      type: 'hif',
      name: 'Cat Infrastructures',
      baseline: empty_baseline_data
    )[:id]
  end

  def get_project(id)
    dependency_factory.get_use_case(:ui_get_project).execute(
      id: id
    )
  end

  context 'Creating the project' do
    it 'Can create the project successfully' do
      project_id = create_project
      created_project = get_project(project_id)

      expect(created_project[:type]).to eq('hif')
      expect(created_project[:name]).to eq('Cat Infrastructures')
      expect(created_project[:data]).to eq(baseline_data)
    end

    it 'Can create an empty project successfully' do
      project_id = create_empty_project
      created_project = get_project(project_id)

      expect(created_project[:type]).to eq('hif')
      expect(created_project[:name]).to eq('Cat Infrastructures')
      expect(created_project[:data]).to eq(empty_baseline_data)
    end
  end

  context 'Updating a project' do
    it 'Can update a created project successfully' do
      project_id = create_project

      dependency_factory.get_use_case(:ui_update_project).execute(id: project_id, data: updated_baseline_data)

      updated_project = get_project(project_id)

      expect(updated_project[:data]).to eq(updated_baseline_data)
    end
  end
end