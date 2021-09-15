push!(LOAD_PATH, joinpath(homedir(), "Documents", "julia"))

try
    using Revise
catch e
    @warn(e.msg)
end

try
    using AbbreviatedStackTraces
catch e
    @warn(e.msg)
end
