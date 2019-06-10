#ifndef BOOK_H
#define BOOK_H

using namespace std;
#include <string>
#include <vector>

class Book
{
private:
    string name;
    string info;
    typedef struct Verse {
        int start;
        int length;
        string info;
    } Verse;
    vector<Verse> verses;
    string text;
public:
    Book(string name);
    void setInfo(string info);
    string getInfo();
    string getName();
    void addVerse(string text, string verseInfo);
    string getVerse(string verseInfo);
    string getText();
    int getVerseStart(string verseInfo);
    int getVerseEnd(string verseInfo);
};

#endif // BOOK_H
