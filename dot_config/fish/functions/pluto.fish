function pluto
    julia --project=. --eval='import Pkg; Pkg.update("Pluto"); import Pluto; Pluto.run()'
end
