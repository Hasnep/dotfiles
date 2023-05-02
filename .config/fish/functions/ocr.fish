function ocr --description="OCR a selection" --argument-names="language"
    set current_datetime (date "+%Y-%m-%d-%H-%M-%S")
    set temporary_screenshot_directory /tmp/ocr
    set temporary_screenshot "$temporary_screenshot_directory/$current_datetime.png"

    mkdir -p $temporary_screenshot_directory

    # Take the screenshot
    switch $XDG_SESSION_TYPE
        case wayland
            flameshot gui --path $temporary_screenshot
        case x11
            import $temporary_screenshot
        case '*'
            echo "Could not detect session type."
            return 1
    end

    # If you didn't specify a language, ask for the language
    if not test -n "$language"
        set language (string join0 (tesseract --list-langs)[2..] | fzf -1 --read0)
    end

    # Return the OCR'd text
    tesseract $temporary_screenshot stdout -l $language txt
end
