sort -k 2 in.txt | perl -anE 'say "$F[0] " . localtime($F[1])'

