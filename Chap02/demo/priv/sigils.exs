~s(This is also a string) #=> This is also a string
~s|This is also a string| #=> "This is also a string"

# Sigils are useful when you want to include quotes in a string.
~s("Do... or do not. There is no try." -Master Yoda)
~s|"Do... or do not. There is no try." -Master Yoda|
#=> "\"Do... or do not. There is no try.\" -Master Yoda"

# Uppercase version ~S that does not handle interpolation
~S(Not interpolated #{3 + 0.14})
#=> "Not interpolated \#{3 + 0.14}"
