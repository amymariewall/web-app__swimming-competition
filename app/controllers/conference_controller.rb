# ALL CONFERENCE CONTROLLERS GO HERE

MyApp.get "/add/conference" do
  erb :"admin/conference/add_conference"
end

MyApp.post "/conference/create" do
  @conference = Conference.new
  @conference.conference_name = params["conference_name"]
  if @conference.is_valid
    @conference.save
    @confirm_message = "Success! Created #{@conference.conference_name}!"
    erb :"admin/confirm_submission"
  else
    erb :"admin/conference/add_conference"
  end
end

MyApp.get "/update/conference/:conference_id" do
  @conference = Conference.find_by_id(params[:conference_id])
  erb :"admin/conference/update_conference"
end

MyApp.post "/process_update_conference_form/:conference_id" do
  @conference = Conference.find_by_id(params[:conference_id])
  @conference.conference_name = params["conference_name"]
  if @conference.is_valid
    @conference.save
    @confirm_message = "Success! Updated #{@conference.conference_name}!"
    erb :"admin/confirm_submission"
  else
    @invalid_conference = Conference.find_by_id(params[:conference_id])
    @invalid_conference.conference_name = params["conference_name"]
    @invalid_conference.is_valid
    @conference = Conference.find_by_id(params[:conference_id])
    @conference.conference_name = @conference.conference_name
    erb :"admin/conference/update_conference"
  end
end

MyApp.post "/delete/conference/:conference_id" do
  @conference = Conference.find_by_id(params[:conference_id])
  if @conference.conference_empty? == true
    @confirm_message = "Success! Deleted #{@conference.conference_name}!"
    @conference.delete
  else
    @confirm_message = "There are Colleges in that Conference, so I will not delete it. Instead, go remove ALL Colleges from that Conference first."
  end
  erb :"admin/confirm_submission"
end

MyApp.get "/read/conferences" do
  @conferences = Conference.all
  erb :"admin/conference/read_conferences"
end