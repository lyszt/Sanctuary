defmodule RyujinCoreWeb.ErrorJSONTest do
  use RyujinCoreWeb.ConnCase, async: true

  test "renders 404" do
    assert RyujinCoreWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert RyujinCoreWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
