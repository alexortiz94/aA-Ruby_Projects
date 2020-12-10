require "byebug"

class Employee
    attr_reader :name, :title, :salary, :boss

    def initialize(name, title, salary, boss=nil)
        @name = name
        @title = title
        @salary = salary
        @boss = boss

        if boss
            up_org_chart = boss
            up_org_chart.sub_employees << self
            until up_org_chart.boss.nil?
                up_org_chart.boss.sub_employees << self
                up_org_chart = up_org_chart.boss
            end
        end
    end

    def bonus(multiplier)
        self.salary * multiplier
    end
end

class Manager < Employee
    attr_reader :sub_employees

    def initialize(name, title, salary, boss=nil, sub_employees=nil)
        super(name, title, salary, boss)
        @sub_employees = sub_employees||= []
    end

    def bonus(multiplier)
        total_sub_employees_salary = self.sub_employees.sum { |sub_employee| sub_employee.salary }
        total_sub_employees_salary * multiplier
    end
end

ned = Manager.new("Ned", "Founder", 1000000)
darren = Manager.new("Darren", "TA Manager", 78000, ned)
shawna = Employee.new("Shawna", "TA", 12000, darren)
david = Employee.new("David", "TA", 10000, darren)

p ned.sub_employees.map(&:name)

p ned.bonus(5) # => 500_000
p darren.bonus(4) # => 88_000
p david.bonus(3) # => 30_000




