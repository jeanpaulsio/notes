# Keeps track of bank account
class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance -= amount
  end
end

# Proxy for our BankAccount (protected)
class AccountProtectionProxy
  def initialize(real_account, owner_name)
    @subject    = real_account
    @owner_name = owner_name
  end

  def method_missing(name, *args)
    check_access
    @subject.send(name, *args)
  end

  def check_access
    raise 'Illegal Access' unless @owner_name == 'JP'
  end
end

account = BankAccount.new(100)
account.deposit(50)
account.withdraw(10)

proxy = AccountProtectionProxy.new(account, 'JP')
proxy.deposit(50)
proxy.withdraw(10)

puts proxy.balance
