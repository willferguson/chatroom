defmodule Chat.Supervisor do
  use GenServer

  def start_link(_) do
    Supervisor.start_link(__MODULE__, [], name: :chat_supervisor)
  end

  def start_room(name) do
    Supervisor.start_child(:chat_supervisor, [name])
  end

  def init(_) do
    Supervisor.init([Chat.Server], strategy: :simple_one_for_one)
  end
end
