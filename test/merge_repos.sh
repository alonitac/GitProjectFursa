set -e

commit_ids=("eb78db6" "78935a3" "b23fbe0" "443da1b" "550423b" "be3123e" "ac6dfa4" "459ed16" "ae85e13" "2ca25ae" "8d1a19a" "0de76c4" "c21cd36" "17244c3" "f2c2a90" "2f9c264" "78c0e71" "74d8c8d" "d5bd2b7" "40c46c9" "eeaf59f" "de1137a" "c3cb6c5" "a7d86d9" "d8adffc" "8091acf" "986d4e3" "af7f718" "16c856a" "8c32745" "dba721c" "3af3d7b" "0407c86" "cabba9e" "38135e7" "1318652" "2f2b2b6" "6579ca4" "bce8733" "f551111" "66c50c3" "fb97b1a" "41505bb" "bd87513" "a4d73fc" "bcfc1ea" "34dfc40" "2139c50" "c719c0d" "929a56c" "68cfaf0" "96990fc")
files=("08vm7FwU.txt" "2JTVGWZk.txt" "b21p9KOx.txt" "eNQUKd4u.txt" "JmbyVIFW.txt" "NNfqsMgg.txt" "q6F9HXIm.txt" "uuze2XeR.txt" "yn8zGcSL.txt" "17mXXGcm.txt" "2xTxOefS.txt" "b4NV2qoo.txt" "F5xCoD8Y.txt" "JNEpnD5K.txt" "NXu8x5io.txt" "QyPgcKxN.txt" "WxdJNXfs.txt" "zwbeTms9.txt" "1a7jUuz2.txt" "8zAhnJvl.txt" "BfEbsOuG.txt" "fUqgXKim.txt" "l0JaOG88.txt" "O0IQfh21.txt" "SrkP9rA6.txt" "X7VFtmRV.txt" "28CAXOBN.txt" "950aPdbx.txt" "cLqrWQw7.txt" "fZ2MOjNf.txt" "L14NtFhe.txt" "O3b4VDgN.txt" "SuNKKBTC.txt" "xpUUyu7l.txt" "293CoKYW.txt" "9jNI8L9r.txt" "dNkfgA3W.txt" "GS4yjVUK.txt" "N6WfxbX8.txt" "PM1q14Ea.txt" "TclGpAHH.txt" "y1IE4zl3.txt" "2jfShj8K.txt" "AQ9eT7PU.txt" "DT0Ndwnv.txt" "iH4ICAzb.txt" "nKLmjeyL.txt" "q5YtTXuC.txt" "Ue2LAqs8.txt" "Y9scFafg.txt")

git checkout main

for commit_id in "${commit_ids[@]}"; do
  if ! git rev-parse --quiet --verify "$commit_id" >/dev/null; then
    echo "Commit ID $commit_id does not exist in the repository, but do exist in GitExerciseOther repo."
    exit 1
  fi
done

for file in "${files[@]}"; do
  if [[ ! -f "../serviceB/$file" ]]; then
    echo "File $file does not exist in the serviceB dir."
  fi
done

echo -e "\n\nGood repositories merge!"