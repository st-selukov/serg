require 'rails_helper'

describe DailyDigestJob do

  it 'daily digest sending' do
    expect(User).to receive(:send_daily_digest)
    DailyDigestJob.perform_now
  end
end
