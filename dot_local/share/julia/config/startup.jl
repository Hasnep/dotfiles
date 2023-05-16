push!(LOAD_PATH, joinpath(homedir(), "Documents", "julia"))

install_instructions = []

try
    using Revise
catch e
    push!(install_instructions, "Pkg.add(\"Revise\")")
end

if length(install_instructions) > 0
    @info "Install missing startup packages:"
    @info join(["import Pkg", install_instructions...], "; ")
end
