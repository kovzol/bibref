#!/bin/bash
# This script obtains all getrefs entries. A complete run may take a long time (several hours).
# Important: You may need a quite large amount of RAM to make this work, at least 5 GB recommended (eventually with swap).
# To speed things up, check for the book Odes is disabled by default. In fact, it should not really be a part of LXX.
BIBREF=../build/bibref
OUTPUT=getrefs-all.csv
GNT=SBLGNT
ONE_TURN=0
INCLUDE_ODES=0
ODES_OPTION=
THREADS=1
SORT_OUTPUT=1

usage() {
 cat <<EOF
Usage: $0 [-h] [-1 | -2] [-d | -D] [-b BIBREF] [-g GNT] [-o OUTPUT] [-p THREADS] [-s | -S]

Obtain all getrefs entries. A complete run may take several hours.

Options:
  -h          Show this help and exit
  -1          do in one turn (may need up to 4x more memory; use with care)
  -2          Process in two parts (default)
  -d          Exclude Odes (default)
  -D          Include Odes
  -b BIBREF   Path to the bibref executable (default: $BIBREF)
  -g GNT      Greek New Testament module (default: $GNT)
  -o OUTPUT   Output CSV file (default: $OUTPUT)
  -p THREADS  Run up to THREADS getrefs commands in parallel (default: 1; use with care)
  -S          Sort the CSV alphabetically and remove duplicate rows (default)
  -s          Do not sort or remove duplicate rows
EOF
}

while getopts ":h12dDb:g:o:p:sS" option; do
 case "$option" in
  h) usage; exit 0 ;;
  1) ONE_TURN=1 ;;
  2) ONE_TURN=0 ;;
  d)
   if [ -n "$ODES_OPTION" ] && [ "$ODES_OPTION" != "d" ]; then
    echo "Options -d and -D cannot be used together." >&2
    exit 2
   fi
   ODES_OPTION=d
   INCLUDE_ODES=0
   ;;
  D)
   if [ -n "$ODES_OPTION" ] && [ "$ODES_OPTION" != "D" ]; then
    echo "Options -d and -D cannot be used together." >&2
    exit 2
   fi
   ODES_OPTION=D
   INCLUDE_ODES=1
   ;;
  b) BIBREF=$OPTARG ;;
  g) GNT=$OPTARG ;;
  o) OUTPUT=$OPTARG ;;
  p) THREADS=$OPTARG ;;
  s) SORT_OUTPUT=0 ;;
  S) SORT_OUTPUT=1 ;;
  :)
   echo "Option -$OPTARG requires an argument." >&2
   usage >&2
   exit 2
   ;;
  \?)
   echo "Unknown option: -$OPTARG" >&2
   usage >&2
   exit 2
   ;;
 esac
done
shift $((OPTIND - 1))
if [ "$#" -gt 0 ]; then
 echo "Unexpected argument: $1" >&2
 usage >&2
 exit 2
fi
if [ "$GNT" != "StatResGNT" ] && [ "$GNT" != "SBLGNT" ]; then
 echo "Invalid GNT module: $GNT (allowed: StatResGNT, SBLGNT)." >&2
 exit 2
fi
case "$THREADS" in
 ''|*[!0-9]*)
 echo "Invalid thread count: $THREADS (must be a positive integer)." >&2
 exit 2
 ;;
esac
THREADS=$((10#$THREADS))
if [ "$THREADS" -eq 0 ]; then
 echo "Invalid thread count: $THREADS (must be a positive integer)." >&2
 exit 2
fi

WORKDIR=$(mktemp -d "${TMPDIR:-/tmp}/getrefs-all.XXXXXX") || exit 1
trap 'rm -rf "$WORKDIR"' EXIT
TASK_COUNT=0
NEXT_TO_WAIT=1
JOB_FAILED=0
declare -a TASK_PIDS

handle_interrupt() {
 trap '' INT TERM
 echo "Interrupted; stopping running getrefs commands..." >&2
 for ((task = NEXT_TO_WAIT; task <= TASK_COUNT; task++)); do
  if [ -n "${TASK_PIDS[$task]}" ]; then
   kill "${TASK_PIDS[$task]}" 2>/dev/null || true
  fi
 done
 for ((task = NEXT_TO_WAIT; task <= TASK_COUNT; task++)); do
  if [ -n "${TASK_PIDS[$task]}" ]; then
   wait "${TASK_PIDS[$task]}" 2>/dev/null || true
  fi
 done
 exit 130
}
trap handle_interrupt INT TERM

wait_for_task() {
 local task=$1
 if ! wait "${TASK_PIDS[$task]}"; then
  cat "$WORKDIR/$task.out" >&2
  JOB_FAILED=1
 elif grep --silent Sorry "$WORKDIR/$task.out"; then
  cat "$WORKDIR/$task.out" >&2
  JOB_FAILED=1
 else
  grep = "$WORKDIR/$task.out" |\
   sed s/\(length=// | sed s/,//g | sed s/pos1=// | sed s/pos2=// | sed s/\)// |\
   sed s/"# "// | sed s/"= "// | sed s/" "/,/g > "$WORKDIR/$task.csv"
 fi
 NEXT_TO_WAIT=$((task + 1))
}

echo "Septuagint module,S. book,S. passage start,S. p. end,Greek New Testament module,GNT book,GNT passage start,GNT p. end,length,S. p. start position,GNT p. start position" > "$OUTPUT"

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
books[10]="I_Kings 22:54"
books[11]="II_Kings 25:30"
books[12]="I_Chronicles 29:30"
books[13]="II_Chronicles 36:23"
books[14]="I_Esdras 9:55"
books[15]="Ezra 10:44"
books[16]="Nehemiah 13:31"
books[17]="Esther 10:3"
books[18]="Judith 16:25"
books[19]="Tobit 14:15"
books[20]="I_Maccabees 16:24"
books[21]="II_Maccabees 15:39"
books[22]="III_Maccabees 7:23"
books[23]="IV_Maccabees 18:24"
books[24]="Proverbs 31:31"
books[25]="Ecclesiastes 12:14"
books[26]="Song_of_Solomon 8:14"
books[27]="Job 42:17"
books[28]="Wisdom 19:22"
books[29]="Sirach 51:30"
books[30]="Psalms_of_Solomon 18:12"
books[31]="Hosea 14:10"
books[32]="Amos 9:15"
books[33]="Micah 7:20"
books[34]="Joel 4:21"
books[35]="Obadiah 1:21"
books[36]="Jonah 4:11"
books[37]="Nahum 3:19"
books[38]="Habakkuk 3:19"
books[39]="Zephaniah 3:20"
books[40]="Haggai 2:23"
books[41]="Zechariah 14:21"
books[42]="Malachi 3:24"
books[43]="Isaiah 66:24"
books[44]="Jeremiah 52:34"
books[45]="Baruch 5:9"
books[46]="Lamentations 5:22"
books[47]="Epistle_of_Jeremiah 1:72"
books[48]="Ezekiel 48:35"
books[49]="Susanna 1:64"
books[50]="Daniel 12:13"
books[51]="Bel_and_the_Dragon 1:42"
books[52]="Odes 14:46"

# Each book will be processed in two runs.

process() {
 # Output format in bibref:
 # LXX Exodus 2:14+37 2:14-110 = SBLGNT Luke 12:14+45 12:14-4 (length=6, pos1=3270, pos2=50522)
 local task out
 TASK_COUNT=$((TASK_COUNT + 1))
 task=$TASK_COUNT
 out="$WORKDIR/$task.out"
 echo "$*"
 printf '%s\n' "$*" > "$WORKDIR/$task.in"
 "$BIBREF" -a -e <"$WORKDIR/$task.in" >"$out" 2>&1 &
 TASK_PIDS[$task]=$!
 if [ "$((task - NEXT_TO_WAIT + 1))" -ge "$THREADS" ]; then
  wait_for_task "$NEXT_TO_WAIT"
 fi
 }

# Process all books (but Psalms)
for book in "${books[@]}"; do
 IFS=" " read -r -a row <<< "${book}"
 bookname="${row[0]}"
 if [ "$bookname" = "Odes" ] && [ "$INCLUDE_ODES" = "0" ]; then
  continue
 fi
 lastverse="${row[1]}"
 IFS=":" read -r -a verseinfo <<< "${lastverse}"
 chapter="${verseinfo[0]}"
 verse="${verseinfo[1]}"
 if [ "$ONE_TURN" = "1" ] || [ "$chapter" = "1" -o "$chapter" = "2" -o "$chapter" = "3" ]; then
  process "getrefs $GNT LXX $bookname 1:1 $lastverse"
 else
  splitchapter=$((chapter/2))
  command1="getrefs $GNT LXX $bookname 1:1 $splitchapter:1"
  command2="getrefs $GNT LXX $bookname $splitchapter:1 $lastverse"
  process "$command1"
  process "$command2"
  fi
 done

# Process Psalms
for p in `seq 1 151`; do
 command="getrefs $GNT LXX Psalms $p"
 process "$command"
 done

while [ "$NEXT_TO_WAIT" -le "$TASK_COUNT" ]; do
 wait_for_task "$NEXT_TO_WAIT"
done

if [ "$JOB_FAILED" -ne 0 ]; then
 echo "One or more getrefs commands failed; see the output above." >&2
 exit 1
fi

for ((task = 1; task <= TASK_COUNT; task++)); do
 cat "$WORKDIR/$task.csv" >> "$OUTPUT"
done

if [ "$SORT_OUTPUT" = "1" ]; then
 head -n 1 "$OUTPUT" > "$WORKDIR/header.csv"
 tail -n +2 "$OUTPUT" | sort -u > "$WORKDIR/sorted.csv"
 cat "$WORKDIR/header.csv" "$WORKDIR/sorted.csv" > "$WORKDIR/final.csv"
 mv "$WORKDIR/final.csv" "$OUTPUT"
fi
