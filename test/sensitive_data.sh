set -e

VUL_COMMIT=$(git log --all --diff-filter=A --pretty=format:"%h" -- testa)

if [ "$(echo $VUL_COMMIT | md5sum | cut -d' ' -f1)" = "$(cat test/vul_hash)" ]
then
  echo "Vulnerable commit found in your repo: $VUL_COMMIT"
  exit 1
fi

C=$(cat test/vul_hash-1)
if [ "$( git cat-file -t $C)" != "commit" ]
then
  echo "The commit before the vulnerable commit ($C) was not found"
  exit 1
fi

git checkout $(git branch --contains $C)
files=("some_file" "some_other_file" "some_file2" "some_other_file2")

for file in "${files[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "File $file expected to be found in the branch"
  fi

  if [[ "$(echo $file | md5sum | cut -d' ' -f1)" != "$(cat $file)" ]]; then
    echo "The content of $file has changed comparing to the original file"
  fi
done

git checkout main

echo "Well done! the repo is clean from vulnerabilities"
