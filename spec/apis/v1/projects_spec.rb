# require "spec_helper"

# describe "/api/v1/projects", :type => :api do
#     let(:user) { create_user! }

#     before do
#       @project = Factory(:project)
#       user.permissions.create!(:action => "view", :thing => @project)
#     end

#     context "projects viewable by this user" do
#       let(:url) { "/api/v1/projects" }
      
#       it "json" do
#         get "#{url}.json"

#         projects_json = Project.for(user).all.to_json
#         last_response.body.should eql(projects_json)
#         last_response.status.should eql(200)
#         projects = JSON.parse(last_response.body)

#         projects.any? do |p|
#           p["project"]["name"] == "Ticketee"
#         end.should be_true
#       end
#     end
# end
