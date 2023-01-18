describe 'execute' do

  it 'Should use the MRI interpreter' do
    expect(RbConfig::CONFIG["RUBY_INSTALL_NAME"]).to eq('ruby') # MRI
  end

end