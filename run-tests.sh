#!/bin/bash
# Usage: run-tests [source_dir]   (default: current dir)
set -e
SRC="${1:-.}"
OUT="$(mktemp -d)"
LIBS="$JUNIT_DIR/junit-4.13.2.jar:$JUNIT_DIR/hamcrest-core-1.3.jar"
find "$SRC" -name '*.java' > "$OUT/sources.txt"
javac -cp "$JUNIT_DIR/junit-console.jar:$LIBS" -d "$OUT" @"$OUT/sources.txt"
java -jar "$JUNIT_DIR/junit-console.jar" execute \
    --class-path "$OUT:$LIBS" \
    --scan-class-path "$OUT"
