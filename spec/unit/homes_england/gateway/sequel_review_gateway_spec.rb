describe HomesEngland::Gateway::SequelReview do
  include_context 'with database'

  let(:gateway) { described_class.new(database: database) }

  context 'can create and find a review' do
    example 1 do
      review = HomesEngland::Domain::RmReview.new.tap do |review|
        review.project_id = 1
        review.data = {}
        review.status = 'Draft'
      end

      new_review_id = gateway.create(review)
      found_review = gateway.find_by(id: new_review_id)

      expect(found_review.id).to eq(new_review_id)
      expect(found_review.project_id).to eq(1)
      expect(found_review.data).to eq({})
      expect(found_review.status).to eq('Draft')
    end

    example 2 do
      review = HomesEngland::Domain::RmReview.new.tap do |review|
        review.project_id = 2
        review.data = { cats: "meow" }
        review.status = 'Submitted'
      end

      new_review_id = gateway.create(review)
      found_review = gateway.find_by(id: new_review_id)

      expect(found_review.id).to eq(new_review_id)
      expect(found_review.project_id).to eq(2)
      expect(found_review.data).to eq({ cats: "meow" })
      expect(found_review.status).to eq('Submitted')
    end
  end
end
