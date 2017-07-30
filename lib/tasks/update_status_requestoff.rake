namespace :request_off do
  desc "Update status Request Off"
  task update_data: :environment do
    RequestOff.where(status: 'pending').
        update_all(status: 'waiting')
  end
end
