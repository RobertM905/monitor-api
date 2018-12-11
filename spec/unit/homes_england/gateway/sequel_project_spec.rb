describe HomesEngland::Gateway::SequelProject do
  include_context 'with database'

  let(:project_gateway) { described_class.new(database: database) }

  context 'updating a non existant project' do
    it 'returns unsuccessful' do
      project = HomesEngland::Domain::Project.new.tap do |p|
        p.name = 'Cat project'
        p.type = 'Animals'
        p.data = { cats: 'meow' }
      end

      response = project_gateway.update(id: 123, project: project)

      expect(response).to eq(success: false)
    end
  end

  context 'example one' do
    let(:project) do
      HomesEngland::Domain::Project.new.tap do |p|
        p.name = 'Cat project'
        p.type = 'Animals'
        p.data = { cats: 'meow' }
      end
    end
    let(:project_id) { project_gateway.create(project) }

    context 'creating the project' do
      it 'creates a new project' do
        created_project = project_gateway.find_by(id: project_id)

        expect(created_project.name).to eq('Cat project')
        expect(created_project.type).to eq('Animals')
        expect(created_project.data).to eq(cats: 'meow')
        expect(created_project.status).to eq('Draft')
      end
    end

    context 'updating the project whilst in Draft' do
      it 'updates the project' do
        project.name = 'Dog project'
        project.data = { dogs: 'woof' }
        project.status = 'Draft'
        project.timestamp = 56789123
        project_gateway.update(id: project_id, project: project)

        created_project = project_gateway.find_by(id: project_id)

        expect(created_project.name).to eq('Dog project')
        expect(created_project.type).to eq('Animals')
        expect(created_project.data).to eq(dogs: 'woof')
        expect(created_project.status).to eq('Draft')
        expect(created_project.timestamp).to eq(56789123)
      end

      it 'returns successful' do
        project.data = { dogs: 'woof' }

        response = project_gateway.update(id: project_id, project: project)

        expect(response).to eq(success: true)
      end
    end

    context 'submitting the project' do
      context 'whilst the status is draft' do
        it 'changes the status to submitted' do
          project.data = { blank: '' }
          project_gateway.submit(id: project_id, status: 'Submitted')
          submitted_project = project_gateway.find_by(id: project_id)

          expect(submitted_project.status).to eq('Submitted')
        end
      end
    end
  end

  context 'example two' do
    let(:project) do
      HomesEngland::Domain::Project.new.tap do |p|
        p.name = 'New project'
        p.type = 'FarmAnimals'
        p.data = {
          field: [
            { animal: 'cow', noise: 'moo' },
            { animal: 'sheep', noise: 'baa' }
          ],
          barn: []
        }
      end
    end
    let(:project_id) { project_gateway.create(project) }

    context 'creating a new project' do
      it 'creates a new project' do
        id = project_gateway.create(project)

        created_project = project_gateway.find_by(id: id)

        expect(created_project.name).to eq('New project')
        expect(created_project.type).to eq('FarmAnimals')
        expect(created_project.data).to eq(
          field: [
            { animal: 'cow', noise: 'moo' },
            { animal: 'sheep', noise: 'baa' }
          ],
          barn: []
        )
      end
    end

    context 'updating an existing project' do
      let(:project_id) { project_gateway.create(project) }

      it 'updates the project' do
        project.data[:barn] << { chicken: 'cluck' }
        project.timestamp = 78912

        project_gateway.update(id: project_id, project: project)

        created_project = project_gateway.find_by(id: project_id)

        expect(created_project.type).to eq('FarmAnimals')
        expect(created_project.data).to eq(
          field: [
            { animal: 'cow', noise: 'moo' },
            { animal: 'sheep', noise: 'baa' }
          ],
          barn: [{ chicken: 'cluck' }]
        )
        expect(created_project.timestamp).to eq(78912)
      end

      it 'returns successful' do
        project.data[:barn] << { chicken: 'cluck' }

        response = project_gateway.update(id: project_id, project: project)

        expect(response).to eq(success: true)
      end
    end
  end

  fcontext 'get all projects' do
    context 'example 1' do
      let(:project) do
        HomesEngland::Domain::Project.new.tap do |p|
          p.name = 'New project'
          p.type = 'FarmAnimals'
          p.data = {
            field: [
              { animal: 'cow', noise: 'moo' },
              { animal: 'sheep', noise: 'baa' }
            ],
            barn: []
          }
        end
      end
      let(:second_project) do
        HomesEngland::Domain::Project.new.tap do |p|
          p.name = 'Second New project'
          p.type = 'UrbanAnimals'
          p.data = {
            field: [
              { animal: 'Fox', noise: 'scream' },
              { animal: 'Badger', noise: 'digging' }
            ],
            barn: []
          }
        end
      end
      it 'returns projects from database' do
        project_gateway.create(project)
        project_gateway.create(second_project)
        all_projects = project_gateway.all
        expect(all_projects[0].name).to eq('New project')
        expect(all_projects[0].type).to eq('FarmAnimals')
        expect(all_projects[0].data).to eq(
                                          field: [
                                            { animal: 'cow', noise: 'moo' },
                                            { animal: 'sheep', noise: 'baa' }
                                          ],
                                          barn: []
                                        )

        expect(all_projects[1].name).to eq('Second New project')
        expect(all_projects[1].type).to eq('UrbanAnimals')
        expect(all_projects[1].data).to eq(
                                          field: [
                                            { animal: 'Fox', noise: 'scream' },
                                            { animal: 'Badger', noise: 'digging' }
                                          ],
                                          barn: []
                                        )
      end
    end
    context 'example 2' do
      let(:project) do
        HomesEngland::Domain::Project.new.tap do |p|
          p.name = 'New project2'
          p.type = 'FarmAnimals2'
          p.data = {
            field: [
              { animal: 'cow2', noise: 'moo2' },
              { animal: 'sheep2', noise: 'baa2' }
            ],
            barn: []
          }
        end
      end
      let(:second_project) do
        HomesEngland::Domain::Project.new.tap do |p|
          p.name = 'Second New project2'
          p.type = 'UrbanAnimals2'
          p.data = {
            field: [
              { animal: 'Fox2', noise: 'scream2' },
              { animal: 'Badger2', noise: 'digging2' }
            ],
            barn: []
          }
        end
      end
      it 'returns projects from database' do
        project_gateway.create(project)
        project_gateway.create(second_project)
        all_projects = project_gateway.all
        expect(all_projects[0].name).to eq('New project2')
        expect(all_projects[0].type).to eq('FarmAnimals2')
        expect(all_projects[0].data).to eq(
                                          field: [
                                            { animal: 'cow2', noise: 'moo2' },
                                            { animal: 'sheep2', noise: 'baa2' }
                                          ],
                                          barn: []
                                        )

        expect(all_projects[1].name).to eq('Second New project2')
        expect(all_projects[1].type).to eq('UrbanAnimals2')
        expect(all_projects[1].data).to eq(
                                          field: [
                                            { animal: 'Fox2', noise: 'scream2' },
                                            { animal: 'Badger2', noise: 'digging2' }
                                          ],
                                          barn: []
                                        )
      end
    end
  end
end
