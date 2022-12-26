function tfapply --wraps terraform
    command terraform apply tfplan $argv
end
