defmodule Chat do
  use Application

  def start(_app, _type) do

    children = [
      {Registry, keys: :unique, name: Chat.Server.registry_name()},
      Chat.Supervisor
    ]
    Supervisor.start_link(children, strategy: :one_for_one)
  end



end
