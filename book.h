#ifndef BOOK_H
#define BOOK_H

#include <string>
#include <vector>

using namespace std;

class Book
{
private:
    string m_name;
    string m_moduleName;
    typedef struct Verse
    {
        int m_start;
        int m_length;
        int m_tokensStart;
        int m_tokensLength;
        string m_info;
    } Verse;
    vector<Verse> m_verses;
    string m_text;
    vector<int> m_tokens;

public:
    Book(const string &name)
        : m_name(name){};
    void setModuleName(const string &moduleName);
    string getModuleName();
    string getName();
    void addVerse(const string &text, const string &info, vector<int> tokens);
    string getVerse(string info);
    string getVerseInfoStart(int position);
    string getVerseInfoEnd(int position);
    string getVerseTokensInfoStart(int position);
    string getVerseTokensInfoEnd(int position);
    string getText();
    vector<int> getVerseTokens(string info);
    vector<int> getTokens();
    int getVerseStart(string info);
    int getVerseEnd(string info);
    int getVerseTokensStart(string info);
    int getVerseTokensEnd(string info);
    // to load a book from cache:
    void setText(const string &text);
    void addVerse(int start, int length, string info, int tokensStart, int tokensLength);
    void setTokens(vector<int> &tokens);
};

#endif // BOOK_H
