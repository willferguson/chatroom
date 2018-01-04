defmodule Chat.Supervisor do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, [], name: :chat_supervisor)
  end

  def start_room(name) do
    Supervisor.start_child(:chat_supervisor, [name])
  end

  def init(_) do
    #Supervisor.init([Chat.Server], strategy: :simple_one_for_one)
    {:ok,
   {%{intensity: 3, period: 5, strategy: :simple_one_for_one},
    [%{id: Chat.Server, restart: :permanent, shutdown: 5000,
       start: {Chat.Server, :start_link, []}, type: :worker}]}}
  end
end
