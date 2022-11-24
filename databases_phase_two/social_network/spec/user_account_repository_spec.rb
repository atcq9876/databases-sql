require 'user_account_repository'

def reset_social_network_tables
  seed_sql = File.read('spec/seeds_social_network.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

RSpec.describe UserAccountRepository do

  before(:each) do
    reset_social_network_tables
  end

  describe "#all" do
    it "returns a list of all user_accounts" do
      repo = UserAccountRepository.new
      user_accounts = repo.all

      expect(user_accounts.length).to eq 3
      expect(user_accounts.first.id).to eq '1'
      expect(user_accounts.last.id).to eq '3'
      expect(user_accounts.last.name).to eq 'Scott'
    end
  end

  describe "#find(id)" do
    it "returns the record of id = 1" do
      repo = UserAccountRepository.new
      user_account = repo.find(1)

      expect(user_account.id).to eq '1'
      expect(user_account.name).to eq 'Andy'
      expect(user_account.email_address).to eq 'andy@gmail.com'
      expect(user_account.username).to eq 'andy123'
    end

    it "returns the record of id = 2" do
      repo = UserAccountRepository.new
      user_account = repo.find(2)
      
      expect(user_account.id).to eq '2'
      expect(user_account.name).to eq 'James'
      expect(user_account.email_address).to eq 'james@outlook.com'
      expect(user_account.username).to eq 'james456'
    end
  end

  describe "#delete(id)" do
    it "deletes record with said id" do
      repo = UserAccountRepository.new
      repo.delete(2)

      user_accounts = repo.all
      expect(user_accounts.length).to eq 2
      expect(user_accounts.last.id).to eq '3'
      expect(user_accounts.last.name).to eq 'Scott'
    end
  end

  describe "#create(user_account)" do
    it "creates a new record" do
      repo = UserAccountRepository.new

      new_user_account = UserAccount.new
      new_user_account.name = 'Lewis'
      new_user_account.email_address = 'lewis@gmail.com'
      new_user_account.username = '1lewis23'

      repo.create(new_user_account)

      user_accounts = repo.all

      expect(user_accounts.last.id).to eq '4'
      expect(user_accounts.last.name).to eq 'Lewis'
      expect(user_accounts.last.email_address).to eq 'lewis@gmail.com'
      expect(user_accounts.last.username).to eq '1lewis23'
    end
  end
end
