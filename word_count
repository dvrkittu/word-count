from fastapi import FastAPI
from collections import Counter

app = FastAPI()

def count_words_from_file():
    try:
        with open("inputlog.txt", "r", encoding="utf-8") as file:
            words = file.read().lower().split()
            word_count = Counter(words)
            return dict(word_count)
    except FileNotFoundError:
        return {"error": "File not found"}

@app.get("/count-words")
def count_words():
    return count_words_from_file()
