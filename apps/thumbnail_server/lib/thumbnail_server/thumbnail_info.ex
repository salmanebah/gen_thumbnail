defmodule ThumbnailInfo do
  @derive [Poison.Encoder]
  defstruct [
    :min_thumbnail_url,
    :mid_thumbnail_url,
    :max_thumbnail_url
  ]
end
