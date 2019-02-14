json.video @video, partial: 'detail', as: :video
if params[:scope].blank? || params[:scope] == 'pre'
  json.pre_videos @video.pre_videos(params.permit(:per)), partial: 'detail', as: :video
end
if params[:scope].blank? || params[:scope] == 'next'
  json.next_videos @video.next_videos(params.permit(:per)), partial: 'detail', as: :video
end
