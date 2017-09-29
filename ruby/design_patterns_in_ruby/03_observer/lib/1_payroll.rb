# Defines an employee in the payroll
class Employee
  attr_reader :name, :title, :salary

  def initialize(name, title, salary, payroll)
    @name    = name
    @title   = title
    @salary  = salary
    @payroll = payroll
  end

  def salary=(new_salary)
    @salary = new_salary
    @payroll.update(self)
  end
end

# Payroll department
class Payroll
  def update(changed_employee)
    puts "Cut a new check for #{changed_employee.name},"\
         " #{changed_employee.title}!"
    puts "His salary is now #{changed_employee.salary}"
  end
end

payroll = Payroll.new
fred = Employee.new('Fred', 'Crane Op', 30_000, payroll)
fred.salary = 35_000
