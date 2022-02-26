function ocr --description="OCR a selection" --argument-names="language"
    set current_datetime (date "+%Y-%m-%d-%H-%M-%S")
    set temporary_screenshot "/tmp/ocr-screenshot-$current_datetime.png"

    # Take the screenshot
    import $temporary_screenshot

    # If you didn't specify a language, ask for the language
    if not test -n "$language"
        set language (string join0 (tesseract --list-langs)[2..] | fzf -1 --read0)
    end

    # Return the OCR'd text
    tesseract $temporary_screenshot stdout -l $language txt
end
