#include <iostream>

using namespace std;

#include "book.h"

void Book::setModuleName(const string &n)
{
    m_moduleName = n;
}

string Book::getName()
{
    return m_name;
}

string Book::getModuleName()
{
    return m_moduleName;
}

void Book::addVerse(const string &n, const string &i, vector<int> t)
{
    int start = m_text.length();
    int length = n.length();
    int tokensStart = m_tokens.size();
    int tokensLength = t.size();
    addVerse(start, length, i, tokensStart, tokensLength);
    m_text += n;
    m_tokens.insert(m_tokens.end(), t.begin(), t.end());
}

void Book::addVerse(int start, int length, string info, int tokensStart, int tokensLength)
{
    Verse v = {start, length, tokensStart, tokensLength, info};
    // cerr << start << " " << length << " " << info << endl;
    m_verses.push_back(v);
}

class InvalidVerseReferenceException : public exception
{
    virtual const char *what() const throw() { return "Invalid verse reference."; }
} InvalidVerseReferenceException;

class InvalidPositionException : public exception
{
    virtual const char *what() const throw() { return "Invalid position."; }
} InvalidPositionException;

string Book::getVerse(string i)
{
    for (int j = 0; j < m_verses.size(); ++j) {
        int match = m_verses[j].m_info.compare(i);
        if (match == 0) {
            string found = m_text.substr(m_verses[j].m_start, m_verses[j].m_length);
            return found;
        }
    }
    throw InvalidVerseReferenceException;
}

vector<int> Book::getVerseTokens(string i)
{
    for (int j = 0; j < m_verses.size(); ++j) {
        int match = m_verses[j].m_info.compare(i);
        if (match == 0) {
            vector<int> found;
            for (int k = 0; k < m_verses[j].m_tokensLength; k++) {
                found.push_back(m_tokens[m_verses[j].m_tokensStart + k]);
            }

            return found;
        }
    }
    throw InvalidVerseReferenceException;
}

string Book::getText()
{
    return m_text;
}

vector<int> Book::getTokens()
{
    return m_tokens;
}

void Book::setText(const string &t)
{
    m_text = t;
    // cerr << text << endl;
}

void Book::setTokens(vector<int> &t)
{
    m_tokens = t;
}

int Book::getVerseStart(string i)
{
    for (int j = 0; j < m_verses.size(); ++j) {
        int match = m_verses[j].m_info.compare(i);
        if (match == 0) {
            int found = m_verses[j].m_start;
            return found;
        }
    }
    throw InvalidVerseReferenceException;
}

int Book::getVerseEnd(string i)
{
    for (int j = 0; j < m_verses.size(); ++j) {
        int match = m_verses[j].m_info.compare(i);
        if (match == 0) {
            int found = m_verses[j].m_start + m_verses[j].m_length - 1;
            return found;
        }
    }
    throw InvalidVerseReferenceException;
}

int Book::getVerseTokensStart(string i)
{
    for (int j = 0; j < m_verses.size(); ++j) {
        int match = m_verses[j].m_info.compare(i);
        if (match == 0) {
            int found = m_verses[j].m_tokensStart;
            return found;
        }
    }
    throw InvalidVerseReferenceException;
}

int Book::getVerseTokensEnd(string i)
{
    for (int j = 0; j < m_verses.size(); ++j) {
        int match = m_verses[j].m_info.compare(i);
        if (match == 0) {
            int found = m_verses[j].m_tokensStart + m_verses[j].m_tokensLength - 1;
            return found;
        }
    }
    throw InvalidVerseReferenceException;
}

string Book::getVerseInfoStart(int position)
{
    for (int j = 0; j < m_verses.size(); ++j) {
        if (m_verses[j].m_start <= position
            && m_verses[j].m_start + m_verses[j].m_length > position) {
            int plus = position - m_verses[j].m_start;
            string retVal = m_verses[j].m_info;
            if (plus == 0) {
                return retVal;
            }
            if (plus > 0) {
                retVal += "+" + to_string(plus);
            }
            return retVal;
        }
    }
    throw InvalidPositionException;
}

string Book::getVerseInfoEnd(int position)
{
    for (int j = 0; j < m_verses.size(); ++j) {
        if (m_verses[j].m_start <= position
            && m_verses[j].m_start + m_verses[j].m_length > position) {
            int minus = m_verses[j].m_start + m_verses[j].m_length - position - 1;
            string retVal = m_verses[j].m_info;
            if (minus == 0) {
                return retVal;
            }
            if (minus > 0) {
                retVal += "-" + to_string(minus);
            }
            return retVal;
        }
    }
    throw InvalidPositionException;
}

string Book::getVerseTokensInfoStart(int position)
{
    for (int j = 0; j < m_verses.size(); ++j) {
        if (m_verses[j].m_tokensStart <= position
            && m_verses[j].m_tokensStart + m_verses[j].m_tokensLength > position) {
            int plus = position - m_verses[j].m_tokensStart;
            string retVal = m_verses[j].m_info;
            if (plus == 0) {
                return retVal;
            }
            if (plus > 0) {
                retVal += "+" + to_string(plus);
            }
            return retVal;
        }
    }
    throw InvalidPositionException;
}

string Book::getVerseTokensInfoEnd(int position)
{
    for (int j = 0; j < m_verses.size(); ++j) {
        if (m_verses[j].m_tokensStart <= position
            && m_verses[j].m_tokensStart + m_verses[j].m_tokensLength > position) {
            int minus = m_verses[j].m_tokensStart + m_verses[j].m_tokensLength - position - 1;
            string retVal = m_verses[j].m_info;
            if (minus == 0) {
                return retVal;
            }
            if (minus > 0) {
                retVal += "-" + to_string(minus);
            }
            return retVal;
        }
    }
    throw InvalidPositionException;
}
