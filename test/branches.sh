set -e

function check_n_commits_by_msg {
  local commit_msg=$1
  local expected_n=$2

  C=$(git log --pretty=format:"%h" --grep="^\s*$commit_msg\s*$")
  N=$(echo "$C" | wc -w)

  if [ "$N" = "0" ]
  then
    echo "Commit '$commit_msg' not found or doesn't exit in branch $BRANCH as expected."
    exit 1
  fi

  if [ "$N" != "$expected_n" ]
  then
    echo "More than $expected_n commits with message '$commit_msg'"
    exit 1
  fi
}

function check_n_parents {
  local commit_id=$1
  local expected_p=$2

  P=$(git log --pretty=format:"%p" -n 1 "$commit_id")
  N=$(echo "$P" | wc -w)
  if [ "$N" != "$expected_p" ]
  then
    echo -e "More than $expected_p parents to commit id $commit_id:\n$P"
    exit 1
  fi
}

function test_tree_structure {
  local commit_msg=$1
  local parent_msg=$2
  local parent2_msg=$3

  if [[ -n "$parent_msg" && -n "$parent2_msg" ]]; then
    local n_parents=2
  else
    local n_parents=1
  fi

  echo "Searching the commit id of '$commit_msg'..."
  check_n_commits_by_msg "$commit_msg" "1"
  COMMIT=$(git log --pretty=format:"%h" --grep="^\s*$commit_msg\s*$")
  echo -e "$commit_msg commit id:\n$C\n"

  echo "Checking that commit $COMMIT ($commit_msg) has exactly $n_parents parent(s)..."
  check_n_parents $COMMIT $n_parents
  C_PARENTS=$(git log --pretty=format:"%p" -n 1 "$COMMIT")
  echo -e "$commit_msg parent commit id(s):\n$C_PARENTS\n"

  for C_PARENT in $C_PARENTS
  do
    C_PARENT_MSG=$(git log --format="%B" -n 1 $C_PARENT)
    if [ "$C_PARENT_MSG" = "$parent_msg" ] || [ "$C_PARENT_MSG" = "$parent2_msg" ]
    then
      break
    else
      echo "The parent of '$commit_msg' is '$C_PARENT_MSG', but expected $parent_msg $parent2_msg"
      exit 1
    fi
  done

  echo -e "'$commit_msg' has defined correctly!\n"

}

BRANCH="main"
git checkout $BRANCH
test_tree_structure "c1" "start here"
test_tree_structure "c2" "c1"
test_tree_structure "c3" "c2"

T_COMMIT_MSG=$(git show --quiet --format=%s v1.0.2)
echo "Checking tag v1.0.2 (commit message $T_COMMIT_MSG)"
test_tree_structure "$T_COMMIT_MSG" "c2" "c11"
test_tree_structure "c6" "$T_COMMIT_MSG"
test_tree_structure "c7" "c3"

T_COMMIT_MSG=$(git show --quiet --format=%s v1.0.3)
echo "Checking tag v1.0.3 (commit message $T_COMMIT_MSG)"
test_tree_structure "$T_COMMIT_MSG" "c7" "c6"
test_tree_structure "c9" "$T_COMMIT_MSG"
test_tree_structure "c10" "c1"
test_tree_structure "c11" "c10"

BRANCH="john/feature1-test"
git checkout $BRANCH
test_tree_structure "c5" "c3"
test_tree_structure "c8" "c5"

git checkout main

echo -e "\n\nWell done! branching question was completed successfully!\n\n"

# TBD check c7 c8 nit in main