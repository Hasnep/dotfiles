push!(LOAD_PATH, joinpath(homedir(), "Documents", "julia"))

# try
#     using OhMyREPL
# catch e
#     @warn(e.msg)
# end

try
    using Revise
catch e
    @warn(e.msg)
end
