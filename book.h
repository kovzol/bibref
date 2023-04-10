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
        int tokensStart;
        int tokensLength;
        string info;
    } Verse;
    vector<Verse> verses;
    string text;
    vector<int> tokens;
public:
    Book(string name);
    void setInfo(string info);
    string getInfo();
    string getName();
    void addVerse(string text, string verseInfo, vector<int> tokens);
    string getVerse(string verseInfo);
    string getVerseInfoStart(int position);
    string getVerseInfoEnd(int position);
    string getVerseTokensInfoStart(int position);
    string getVerseTokensInfoEnd(int position);
    string getText();
    vector<int> getVerseTokens(string verseInfo);
    vector<int> getTokens();
    int getVerseStart(string verseInfo);
    int getVerseEnd(string verseInfo);
    int getVerseTokensStart(string verseInfo);
    int getVerseTokensEnd(string verseInfo);
    // to load a book from cache:
    void setText(string text);
    void addVerse(int start, int length, string info, int tokensStart, int tokensLength);
    void setTokens(vector<int> tokens);
};

#endif // BOOK_H
