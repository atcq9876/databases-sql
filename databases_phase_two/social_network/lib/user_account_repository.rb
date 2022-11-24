require_relative 'user_account'

class UserAccountRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query below:
    sql = "SELECT id, name, email_address, username FROM user_accounts;"
    result_set = DatabaseConnection.exec_params(sql, [])

    user_accounts = []

    result_set.each do |record|
      user_account = UserAccount.new
      user_account.id = record["id"]
      user_account.name = record["name"]
      user_account.email_address = record["email_address"]
      user_account.username = record["username"]

      user_accounts << user_account
    end

    return user_accounts
  end

  # Finding one record
  # Taking the record id as an argument
  def find(id)
    sql = "SELECT id, name, email_address, username FROM user_accounts WHERE id = $1;"

    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    user_account = UserAccount.new
    user_account.id = record["id"]
    user_account.name = record["name"]
    user_account.email_address = record["email_address"]
    user_account.username = record["username"]

    return user_account
    # (The code now needs to convert the result to an Album object and return it)
  end

  # Creating a new user_account record (takes an instance of UserAccount)
  def create(user_account)
    sql = "INSERT INTO user_accounts (name, email_address, username) VALUES($1, $2, $3);"
    params = [user_account.name, user_account.email_address, user_account.username]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end


  def delete(id)
    sql = "DELETE FROM user_accounts WHERE id = $1"
    params = [id]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end


  # # def update(user_account)
  # # end
end