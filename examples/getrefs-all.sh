#!/bin/bash
# This script obtains all getrefs entries. A complete run may take a long time (several hours).
# FIXME: Some entries are duplicated, duplums should be removed.
BIBREF=../build/bibref
OUTPUT=getrefs-all.csv

echo "Septuagint module,S. book,S. passage start,S. p. end,Greek New Testament module,GNT book,GNT passage start,GNT p. end,length,S. p. start position,GNT p. start position" > $OUTPUT

declare -a books
books[0]="Genesis 50:26"
books[1]="Exodus 40:38"
books[2]="Leviticus 27:34"
books[3]="Numbers 36:13"
books[4]="Deuteronomy 34:12"
books[5]="Joshua 24:33"
books[6]="Judges 26:25"
books[7]="Ruth 4:22"
books[8]="I_Samuel 31:13"
books[9]="II_Samuel 24:25"
books[10]="I_Kings 22:53"
books[11]="II_Kings 25:30"
books[12]="I_Chronicles 29:30"
books[13]="II_Chronicles 36:23"
books[14]="Esra 10:44"
books[15]="Nehemiah 13:31"
books[16]="Esther 10:3"
books[17]="Job 42:17"
books[18]="Proverbs 31:31"
books[19]="Ecclesiastes 12:14"
books[20]="Song_of_Solomon 8:14"
books[21]="Isaiah 66:24"
books[22]="Jeremiah 52:34"
books[23]="Lamentations 5:22"
books[24]="Ezekiel 48:35"
books[25]="Daniel 12:13"
books[26]="Hosea 14:9"
books[27]="Joel 3:21"
books[28]="Amos 9:15"
books[29]="Obadiah 1:21"
books[30]="Jonah 4:11"
books[31]="Micah 7:20"
books[32]="Nahum 3:19"
books[33]="Habakkuk 3:19"
books[34]="Zephaniah 3:20"
books[35]="Haggai 2:23"
books[36]="Zechariah 14:21"
books[37]="Malachi 4:6"

# Each book will be processed in two runs.

process() {
 # Output format in bibref:
 # LXX Exodus 2:14+37 2:14-110 = SBLGNT Luke 12:14+45 12:14-4 (length=6, pos1=3270, pos2=50522)
 echo $*
 echo $* | $BIBREF -a -e 2>&1 | grep = |\
  sed s/\(length=// | sed s/,//g | sed s/pos1=// | sed s/pos2=// | sed s/\)// |\
  sed s/"# "// | sed s/"= "// | sed s/" "/,/g >> $OUTPUT
 }

# Process all books (but Psalms)
for book in "${books[@]}"; do
 IFS=" " read -r -a row <<< "${book}"
 bookname="${row[0]}"
 lastverse="${row[1]}"
 IFS=":" read -r -a verseinfo <<< "${lastverse}"
 chapter="${verseinfo[0]}"
 verse="${verseinfo[1]}"
 splitchapter=$((chapter/2))
 command1="getrefs SBLGNT LXX $bookname 1:1 $splitchapter:1"
 command2="getrefs SBLGNT LXX $bookname $splitchapter:1 $lastverse"
 process "$command1"
 process "$command2"
 done

# Process Psalms
for p in `seq 1 150`; do
 command="getrefs SBLGNT LXX Psalms $p"
 process "$command"
 done
