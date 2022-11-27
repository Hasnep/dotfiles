function jlfmt --wraps julia
    julia --startup-file=no --quiet --compile=min --optimize=0 --eval 'import JuliaFormatter; JuliaFormatter.format(".")' $argv
end
