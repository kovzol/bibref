#ifndef PSALMSINFO_H
#define PSALMSINFO_H

#include <string>

using namespace std;

class PsalmsInfo
{
private:
    string m_info;
    int m_lastVerse[152]; // the 0th one will be unused
public:
    PsalmsInfo(const string &info)
        : m_info(info)
    {
        for (int i = 0; i < 152; i++) {
            m_lastVerse[i] = 0;
        }
    };
    void setLastVerse(int psalm, int lastVerse);
    int getLastVerse(int psalm);
    string getInfo();
};

#endif // PSALMSINFO_H
