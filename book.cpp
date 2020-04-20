#include <iostream>

#include "book.h"

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

class InvalidVerseReference: public exception
{
  virtual const char* what() const throw()
  {
    return "Invalid verse reference.";
  }
} InvalidVerseReference;

class InvalidPosition: public exception
{
  virtual const char* what() const throw()
  {
    return "Invalid position.";
  }
} InvalidPosition;

string Book::getVerse(string i) {
    for (int j=0; j<verses.size(); ++j) {
        int match = verses[j].info.compare(i);
        if (match == 0) {
            string found = text.substr(verses[j].start,verses[j].length);
            return found;
        }
    }
    throw InvalidVerseReference;
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
    throw InvalidVerseReference;
}

int Book::getVerseEnd(string i) {
    for (int j=0; j<verses.size(); ++j) {
        int match = verses[j].info.compare(i);
        if (match == 0) {
            int found = verses[j].start + verses[j].length - 1;
            return found;
        }
    }
    throw InvalidVerseReference;
}

string Book::getVerseInfoStart(int position) {
    for (int j=0; j<verses.size(); ++j) {
        if (verses[j].start <= position && verses[j].start + verses[j].length > position) {
            int plus = position - verses[j].start;
            string retVal = verses[j].info;
            if (plus == 0) {
                return retVal;
            }
            if (plus > 0) {
                retVal += "+" + to_string(plus);
            }
            return retVal;
        }
    }
    throw InvalidPosition;
}

string Book::getVerseInfoEnd(int position) {
    for (int j=0; j<verses.size(); ++j) {
        if (verses[j].start <= position && verses[j].start + verses[j].length > position) {
            int minus = verses[j].start + verses[j].length - position - 1;
            string retVal = verses[j].info;
            if (minus == 0) {
                return retVal;
            }
            if (minus > 0) {
                retVal += "-" + to_string(minus);
            }
            return retVal;
        }
    }
    throw InvalidPosition;
}
