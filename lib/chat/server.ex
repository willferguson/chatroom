defmodule Chat.Server do
  use GenServer, start: {__MODULE__, :start_link, []}

  @registry_name Registry.ChatRoom

  def start_link(name) do
    GenServer.start_link(__MODULE__, [], name: via_registry(name))
  end
  def add_message(name, message) do
    GenServer.cast(via_registry(name), {:add_message, message})
  end
  def get_messages(name) do
    GenServer.call(via_registry(name), :get_messages)
  end
  # SERVER
  def init(messages) do
    {:ok, messages}
  end
  def handle_cast({:add_message, new_message}, messages) do
    {:noreply, [new_message | messages]}
  end
  def handle_call(:get_messages, _from, messages) do
    {:reply, messages, messages}
  end

  defp via_registry(name) do
    {:via, Registry, {@registry_name, name}}
  end

  def registry_name do
    @registry_name
  end
end
