require "spec_helper"

RSpec.describe "Routes for Doctor", type: :routing do

  it "Does routing to doctor/health_check_controller:index" do
    expect(get: doctor_root_path).to route_to(controller: "doctor/health_check", action: "index" )
  end

end
