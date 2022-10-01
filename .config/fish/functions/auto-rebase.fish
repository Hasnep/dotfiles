function auto-rebase --argument-names main_branch_name
    if not set -q main_branch_name
        set main_branch_name (git fetch && git branch | string sub --start 3 | fzf --header 'Main branch')
    end
    set current_branch (git branch --show-current)
    git switch $main_branch_name \
        && git pull --autostash \
        && git switch $current_branch \
        && git rebase --autostash --interactive $main_branch_name
end
