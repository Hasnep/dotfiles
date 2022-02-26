complete --command=ocr --no-files
complete --command=ocr --arguments=(string join " " (tesseract --list-langs)[2..])
