describe UI::UseCase::ConvertUIHIFProject do
  let(:project_to_convert) do
    JSON.parse(
      File.open("#{__dir__}/../../../fixtures/hif_baseline_ui.json").read,
      symbolize_names: true
    )
  end

  let(:core_data_project) do
    JSON.parse(
      File.open("#{__dir__}/../../../fixtures/hif_baseline_core.json").read,
      symbolize_names: true
    )
  end

  it 'Converts the project correctly' do
    converted_project = described_class.new.execute(project_data: project_to_convert)

    expect(converted_project).to eq(core_data_project)
  end
end
