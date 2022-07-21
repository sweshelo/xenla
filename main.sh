#!/bin/bash

function convert_symbol_to_keywords() {
  local symbol=$1
  case $symbol in
    "'" ) echo "apostrophe" ;;
    "\"" ) echo "quotedbl" ;;
    "[" ) echo "bracketleft" ;;
    "]" ) echo "bracketright" ;;
    "{" ) echo "braceleft" ;;
    "}" ) echo "braceright" ;;
    "/" ) echo "slash" ;;
    "?" ) echo "question" ;;
    "<" ) echo "less" ;;
    ">" ) echo "greater" ;;
    "." ) echo "period" ;;
    "," ) echo "comma" ;;
    * ) echo $symbol ;;
  esac
  return 0
}

# constants
KEYCODES=({{24..35},{38..48},{52..61}})
QWERTY=('q' 'w' 'e' 'r' 't' 'y' 'u' 'i' 'o' 'p' '[' ']' 'a' 's' 'd' 'f' 'g' 'h' 'j' 'k' 'l' ';' '"' 'z' 'x' 'c' 'v' 'b' 'n' 'm' ',' '.' '/')
QWERTY_SHIFT=('Q' 'W' 'E' 'R' 'T' 'Y' 'U' 'I' 'O' 'P' '{' '}' 'A' 'S' 'D' 'F' 'G' 'H' 'J' 'K' 'L' ':' '"' 'Z' 'X' 'C' 'V' 'B' 'N' 'M' '<' '>' '?')

# check config file
if [ ! -f $1 ]; then
  echo "Config file not found"
  exit 1
fi

# check emergency key
if [ "$2" != "" ]; then
  SWITCH=$2
else
  SWITCH=
fi

# check config file format
CONFIG=(`perl -pe 's/\n//' $1`)

i=0
for code in "${KEYCODES[@]}"; do
  KEY=`convert_symbol_to_keywords ${CONFIG:$i:1}`
  KEY_SHIFT=`convert_symbol_to_keywords ${CONFIG:$i+33:1}`
  if [ "$SWITCH" == "" ]; then
    KEY_SWITCH=$KEY
    KEY_SWITCH_SHIFT=$KEY_SHIFT
  else
    KEY_SWITCH=`convert_symbol_to_keywords ${QWERTY[$i]}`
    KEY_SWITCH_SHIFT=`convert_symbol_to_keywords ${QWERTY_SHIFT[$i]}`
  fi
  echo "keycode $code = $KEY $KEY_SHIFT $KEY_SWITCH $KEY_SWITCH_SHIFT"
  i=$((i+1))
done

if [ "$SWITCH" == "" ]; then
  echo "keycode $SWITCH = Mode_switch"
fi
