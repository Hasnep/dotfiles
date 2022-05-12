push!(LOAD_PATH, joinpath(homedir(), "Documents", "julia"))

try
    using Revise
catch e
    @warn(e.msg)
    @info "Command to install Revise:"
    @info "import Pkg; Pkg.add(\"Revise\")."
end

try
    using AbbreviatedStackTraces
catch e
    @warn(e.msg)
    @info "Command to install AbbreviatedStackTraces:"
    @info "import Pkg; Pkg.add(url=\"https://github.com/BioTurboNick/AbbreviatedStackTraces.jl\")"
end

try
    using JuliaFormatter
catch e
    @warn(e.msg)
    @info "Command to install JuliaFormatter:"
    @info "import Pkg; Pkg.add(\"JuliaFormatter\")"
end
