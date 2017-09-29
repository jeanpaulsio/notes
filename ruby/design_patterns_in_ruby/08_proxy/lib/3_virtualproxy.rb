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

# Virtual proxy for laziness
class VirtualAccountProxy
  def initialize(&creation_block)
    @creation_block = creation_block
  end

  def deposit(amount)
    s = subject
    s.deposit(amount)
  end

  def withdraw(amount)
    s = subject
    s.withdraw(amount)
  end

  def balance
    s = subject
    s.balance
  end

  def subject
    @subject || @subject = @creation_block.call
  end
end

account = VirtualAccountProxy.new { BankAccount.new(10) }
puts account.balance
