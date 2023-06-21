function auto-rebase --argument-names main_branch_name
    # If the main branch was not passed as a CLI argument then ask for it interactively using fzf
    if not set -q main_branch_name
        set main_branch_name (git fetch && git branch | string sub --start 3 | fzf --header 'Main branch')
    end
    # Get the current branch name
    set current_branch_name (git branch --show-current)
    if test $current_branch_name = $main_branch_name
        echo "Current branch is already `$main_branch_name`, I'll just pull."
        git pull --autostash
    else
        git switch $main_branch_name \
            && git pull --autostash \
            && git switch $current_branch_name \
            && git rebase --autostash --interactive $main_branch_name
    end
end
