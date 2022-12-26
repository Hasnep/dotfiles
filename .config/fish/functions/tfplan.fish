function tfplan --wraps terraform
    command terraform plan -out=tfplan $argv
end
