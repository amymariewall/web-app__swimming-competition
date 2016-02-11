# ALL CONFERENCE CONTROLLERS GO HERE

MyApp.get "/add/conference" do
  erb :"admin/add_conference"
end

MyApp.get "/conference/create" do
  @conference = Conference.new
  @conference.conference_name = params["conference_name"]
  @conference.save
  erb :"admin/confirm_submission"
end

MyApp.get "/read/conferences" do
  @conferences = Conference.all
  erb :"admin/read_conferences"
end