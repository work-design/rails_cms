json.audios @audios, partial: 'audio', as: :audio
json.partial! 'api/shared/pagination', items: @audios
