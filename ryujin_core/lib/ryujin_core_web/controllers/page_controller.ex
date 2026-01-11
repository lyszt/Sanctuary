defmodule RyujinCoreWeb.PageController do
  use RyujinCoreWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
