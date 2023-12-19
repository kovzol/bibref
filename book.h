#ifndef BOOK_H
#define BOOK_H

#include <string>
#include <vector>

using namespace std;

class Book
{
private:
  string name;
  string moduleName;
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
  void setModuleName(string moduleName);
  string getModuleName();
  string getName();
  void addVerse(string text, string info, vector<int> tokens);
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
  void setText(string text);
  void addVerse(int start, int length, string info, int tokensStart, int tokensLength);
  void setTokens(vector<int> tokens);
};

#endif // BOOK_H
