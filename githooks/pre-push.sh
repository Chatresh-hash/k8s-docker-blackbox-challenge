#!/bin/sh
if grep -r "SECRET_KEY" .; then
  echo "Secret detected! Commit blocked."
  exit 1
fi

