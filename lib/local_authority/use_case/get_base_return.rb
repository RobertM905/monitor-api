# frozen_string_literal: true

class LocalAuthority::UseCase::GetBaseReturn
  def initialize(return_gateway:, project_gateway:, populate_return_template:, get_returns:)
    @return_gateway = return_gateway
    @project_gateway = project_gateway
    @populate_return_template = populate_return_template
    @get_returns = get_returns
  end

  def execute(project_id:)
    return_data = get_return_data_for_project(project_id)
    project = @project_gateway.find_by(id: project_id)
    schema = @return_gateway.find_by(type: project.type)
    data = populate_return(project, return_data)
    
    { base_return: { id: project_id, data: data, schema: schema.schema } }
  end

  private

  def project_has_returns?(return_data)
    !return_data.nil?
  end

  def get_return_data_for_project(project_id)
    submitted_returns = @get_returns.execute(
      project_id: project_id
    )[:returns]&.select do |return_data|
      return_data[:status] == 'Submitted'
    end

    submitted_returns&.dig(-1, :updates, -1)
  end

  def populate_return(project, return_data)
    if project_has_returns?(return_data)
      @populate_return_template.execute(
        type: project.type,
        baseline_data: project.data,
        return_data: return_data
      )[:populated_data]
    else
      @populate_return_template.execute(
        type: project.type,
        baseline_data: project.data
      )[:populated_data]
    end
  end
end
