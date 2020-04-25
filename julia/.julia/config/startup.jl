push!(LOAD_PATH, "/home/hannes/Documents/Julia/")

try
    using OhMyREPL 
catch e 
    @warn(e.msg)
end

try
    using Revise 
catch e
    @warn(e.msg)
end
