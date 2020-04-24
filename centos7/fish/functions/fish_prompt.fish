function fish_prompt
    switch $USER
    case root
        echo -n '# '
    case '*'
        echo -n '$ '
    end
end
