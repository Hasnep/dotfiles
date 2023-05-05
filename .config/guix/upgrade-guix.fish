if type --query --no-functions guix
    if set --query GUIX_MANIFEST GUIX_PROFILE
        guix pull && guix package --manifest=$GUIX_MANIFEST --profile=$GUIX_PROFILE --upgrade=.
    else
        echo "Environment variables 'GUIX_MANIFEST' and 'GUIX_PROFILE' not set."
        exit 1
    end
else
    echo "Guix not installed"
end
