defmodule URI.Parser do
  @moduledoc """
  为url parser定义行为
  """
  use Behaviour

  @doc """
  负责解析URL信息
  """
  defcallback parse(uri_info: URI.Info.t) :: URI.Info.t

  @doc """
  return default port
  """
  defcallback default_port() :: Integer
end

defmodule URI.HTTP do
  @behaviour URI.Parser

  def default_port, do: 80

  def parse(info), do: info
end
