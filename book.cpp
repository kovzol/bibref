#include "book.h"
#include <iostream>

using namespace std;

Book::Book (string n) {
    name = n;
    // cerr << "Book " << n << " created" << endl;
}

void Book::setInfo(string n) {
    info = n;
}

string Book::getName() {
    return name;
}

string Book::getInfo() {
    return info;
}

void Book::addVerse(string n, string i) {
    int start = text.length();
    int length = n.length();
    Verse v = {start, length, i};
    verses.push_back(v);
    text += n;
}

string Book::getVerse(string i) {
    for (int j=0; j<verses.size(); ++j) {
        int match = verses[j].info.compare(i);
        if (match == 0) {
            string found = text.substr(verses[j].start,verses[j].length);
            return found;
        }
    }
}

string Book::getText() {
    return text;
}

int Book::getVerseStart(string i) {
    for (int j=0; j<verses.size(); ++j) {
        int match = verses[j].info.compare(i);
        if (match == 0) {
            int found = verses[j].start;
            return found;
        }
    }
}

int Book::getVerseEnd(string i) {
    for (int j=0; j<verses.size(); ++j) {
        int match = verses[j].info.compare(i);
        if (match == 0) {
            int found = verses[j].start + verses[j].length - 1;
            return found;
        }
    }
}

