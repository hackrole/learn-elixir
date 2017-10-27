defmodule Hello.HelloController do
  use Hello.Web, :controller

  def world(conn, _params) do
    render conn, "world.html"
  end

  def world2(conn, %{"name" => name}) do
    render conn, "world2.html", name: name
  end

end
