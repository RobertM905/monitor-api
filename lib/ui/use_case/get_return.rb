# frozen_string_literal: true

class UI::UseCase::GetReturn
  def initialize(get_return:, convert_core_return:)
    @get_return = get_return
    @convert_core_return = convert_core_return
  end

  def execute(id:)
    found_return = @get_return.execute(id: id)

    found_return[:updates] = found_return[:updates].map do |update|
      @convert_core_return.execute(return_data: update, type: found_return[:type])
    end

    {
      id: found_return[:id],
      type: found_return[:type],
      project_id: found_return[:project_id],
      status: found_return[:status],
      updates: found_return[:updates]
    }
  end
end
