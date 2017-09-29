# SUBJECT module
module Subject
  def initialize
    @observers = []
  end

  def add_observer(observer)
    @observers << observer
  end

  def delete_observer(observer)
    @observers.delete(observer)
  end

  def notify_observers
    @observers.each { |observer| observer.update(self) }
  end
end

# Employee Subject
class Employee
  include Subject

  attr_reader :name, :title, :salary

  def initialize(name, title, salary)
    super()
    @name   = name
    @title  = title
    @salary = salary
  end

  def salary=(new_salary)
    @salary = new_salary
    notify_observers
  end
end

# OBSERVERS
# Payroll department
class Payroll
  def update(changed_employee)
    puts "Cut a new check for #{changed_employee.name},"\
         " #{changed_employee.title}!"
    puts "His salary is now #{changed_employee.salary}"
  end
end

# Tax department
class TaxMan
  def update(changed_employee)
    puts "Send #{changed_employee.name} a new tax bill"
  end
end

payroll = Payroll.new
tax_man = TaxMan.new
fred = Employee.new('Fred', 'Crane Op', 30_000)
fred.add_observer(payroll)
fred.add_observer(tax_man)
fred.salary = 45_000
