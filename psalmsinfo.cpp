using namespace std;

#include "psalmsinfo.h"

class InvalidPsalmException : public exception
{
    virtual const char *what() const throw() { return "Invalid psalm."; }
} InvalidPsalmException;

string PsalmsInfo::getInfo()
{
    return m_info;
}

int PsalmsInfo::getLastVerse(int p)
{
    if (p < 1 || p > 151)
        throw InvalidPsalmException;
    return m_lastVerse[p];
}

void PsalmsInfo::setLastVerse(int p, int v)
{
    if (p < 1 || p > 151)
        throw InvalidPsalmException;
    m_lastVerse[p] = v;
}
