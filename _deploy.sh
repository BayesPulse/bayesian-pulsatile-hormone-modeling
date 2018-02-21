#!/bin/sh

set -e
set -x

[ -z "${GITHUB_PAT}" ] && exit 0
[ "${TRAVIS_BRANCH}" != "master" ] && exit 0

git config --global user.email "matthew.mulvahill@ucdenver.edu"
git config --global user.name "Matt Mulvahill"

git clone -b master https://${GITHUB_PAT}@github.com/BayesPulse/bayespulse.github.io.git book-output
cd book-output
pwd
ls -la
cp -r ../_book/* ./
git add --all *
git status
ls -la
git commit -m "Update the book" || true
git push -q origin master

