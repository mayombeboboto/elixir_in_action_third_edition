person = %{name: "Bob", age: 31, works_at: "Safeboda"}

person.sex #=> ** (KeyError)
person.name #=> "Bob"
person[:sex] #=> nil

key = :sex
person[key] #=> nil

key = :name
person[key] #=> "Bob"

# Update
person = %{person | works_at: "PMT"}
#=> %{name: "Bob", age: 31, works_at: "PMT"}

%{person | unknown: "PMT"} #=> ** (KeyError)

student = %{"name" => "Ezekial", "sex" => :f}
student = %{student | "sex" => :m}
#=> %{"name" => "Ezekial", "sex" => :m}
