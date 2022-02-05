#ifndef PSALMSINFO_H
#define PSALMSINFO_H

using namespace std;

class PsalmsInfo
{
private:
    string info;
    int lastVerse[152]; // the 0th one will be unused
public:
    PsalmsInfo(string info);
    void setLastVerse(int psalm, int lastVerse);
    int getLastVerse(int psalm);
    string getInfo();
};

#endif // PSALMSINFO_H
