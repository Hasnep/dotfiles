push!(LOAD_PATH, "~/Documents/Julia/")

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
