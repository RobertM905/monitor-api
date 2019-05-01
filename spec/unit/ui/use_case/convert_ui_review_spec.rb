describe UI::UseCase::ConvertUIReview do
  let(:convert_ui_hif_review_spy) { spy(execute: {id: 1, project_id: 7, data:{ some_data:'lad' }, status:'Draft'}) }
  let(:usecase) do
    described_class.new(
      convert_ui_hif_review: convert_ui_hif_review_spy
    )
  end
  context 'hif' do
    it 'calls the convert use case' do
      usecase.execute(type: 'hif', review_data: { some_data: 'data value' })
      expect(convert_ui_hif_review_spy).to have_received(:execute).with(
        review_data: { some_data: 'data value' }
      )
    end

    it 'returns the created review' do
      new_review = usecase.execute(type: 'hif', review_data: { some_data:'lad' })
      expect(new_review).to eq({id: 1, project_id: 7, data:{ some_data:'lad' }, status:'Draft'})
    end
  end

  context 'not hif' do
    it 'returns nil' do
      response = usecase.execute(type: 'not hif', review_data: { some_data: 'data value' })
      expect(response).to eq(nil)
    end
  end
end