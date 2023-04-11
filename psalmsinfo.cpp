#include <iostream>

using namespace std;

#include "psalmsinfo.h"

class InvalidPsalm: public exception
{
  virtual const char* what() const throw()
  {
    return "Invalid psalm.";
  }
} InvalidPsalm;

PsalmsInfo::PsalmsInfo (string n) {
  info = n;
}

string PsalmsInfo::getInfo() {
  return info;
}

int PsalmsInfo::getLastVerse(int p) {
  if (p<1 || p>151) throw InvalidPsalm;
  return lastVerse[p];
}

void PsalmsInfo::setLastVerse(int p, int v) {
  if (p<1 || p>151) throw InvalidPsalm;
  lastVerse[p] = v;
}
