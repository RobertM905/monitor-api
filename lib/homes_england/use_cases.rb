# frozen_string_literal: true

class HomesEngland::UseCases
  def self.register(builder)
    builder.define_use_case :create_new_project do
      HomesEngland::UseCase::CreateNewProject.new(
        project_gateway: builder.get_gateway(:project)
      )
    end

    builder.define_use_case :find_project do
      HomesEngland::UseCase::FindProject.new(
        project_gateway: builder.get_gateway(:project)
      )
    end

    builder.define_use_case :update_project do
      HomesEngland::UseCase::UpdateProject.new(
        project_gateway: builder.get_gateway(:project)
      )
    end

    builder.define_use_case :validate_project do
      HomesEngland::UseCase::ValidateProject.new(
        project_template_gateway: builder.get_gateway(:template),
        get_project_template_path_titles: builder.get_use_case(:get_template_path_titles)
      )
    end

    builder.define_use_case :submit_project do
      HomesEngland::UseCase::SubmitProject.new(
        project_gateway: builder.get_gateway(:project)
      )
    end

    builder.define_use_case :get_schema_for_project do
      HomesEngland::UseCase::GetSchemaForProject.new(
        template_gateway: builder.get_gateway(:template)
      )
    end

    builder.define_use_case :populate_template do
      HomesEngland::UseCase::PopulateTemplate.new(
        template_gateway: builder.get_gateway(:template)
      )
    end

    builder.define_use_case :add_user do
      HomesEngland::UseCase::AddUser.new(
        user_gateway: builder.get_gateway(:users)
      )
    end

    builder.define_use_case :add_user_to_project do
      HomesEngland::UseCase::AddUserToProject.new(
        user_gateway: builder.get_gateway(:users)
      )
    end

    builder.define_use_case :get_project_users do
      HomesEngland::UseCase::GetProjectUsers.new(
        user_gateway: builder.get_gateway(:users)
      )
    end

    builder.define_use_case :export_project_data do
      HomesEngland::UseCase::ExportProjectData.new(
        find_project: builder.get_use_case(:find_project),
        get_returns: builder.get_use_case(:get_returns)
      )
    end
  end
end
