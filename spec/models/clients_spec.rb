require 'rails_helper'

describe Client do
  it 'has a valid factory' do
    expect(build(:client)).to be_valid
  end
  
  it 'is invalid without a zip code' do
    expect(build(:client, zip: nil)).to_not be_valid
  end
  
  it 'is invalid if zip contains anything but a string of digits' do
    expect(build(:client, zip: 00000)).to_not be_valid
    expect(build(:client, zip: '01bb2')).to_not be_valid
    expect(build(:client, zip: true)).to_not be_valid
  end
  
  it 'is invalid if zip not exactly 5 char long' do
    expect(build(:client, zip: '0247')).to_not be_valid
  end
  
  it 'is invalid without a billing address' do
    expect(build(:client, billing_address: nil)).to_not be_valid
  end  
  
  it 'is invalid without a job address' do
    expect(build(:client, job_address: nil)).to_not be_valid
  end
  
    it 'is invalid without a city' do
    expect(build(:client, city: nil)).to_not be_valid
  end
  
    it 'is invalid if state is not a two capital-letter string' do
      expect(build(:client, state:1)).to_not be_valid
      expect(build(:client, state:"a")).to_not be_valid
      expect(build(:client, state:"Ma")).to_not be_valid
      expect(build(:client, state:"20")).to_not be_valid
      expect(build(:client, state:"MAN")).to_not be_valid
    end
  
end