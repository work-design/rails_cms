class Audio < ApplicationRecord
  include RailsMedia::Audio
end unless defined? Audio
