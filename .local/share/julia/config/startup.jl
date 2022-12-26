push!(LOAD_PATH, joinpath(homedir(), "Documents", "julia"))

install_instructions = []

try
    using Revise
catch e
    push!(install_instructions, "Pkg.add(\"Revise\")")
end

try
    using AbbreviatedStackTraces
catch e
    push!(install_instructions, "Pkg.add(url=\"https://github.com/BioTurboNick/AbbreviatedStackTraces.jl\")")
end

try
    using CuratedSystemImages
catch e
    push!(install_instructions, "Pkg.add(url=\"https://github.com/MichaelHatherly/CuratedSystemImages.jl\"); import CuratedSystemImages; CuratedSystemImages.install()")
end

if length(install_instructions) > 0
    @info "Install missing startup packages:"
    @info join(["import Pkg", install_instructions...], "; ")
end
