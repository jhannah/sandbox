sort -k 2 in.txt | perl -anE 'say "$F[0] " . localtime($F[1])'

# or 

perl -anE 'push @rows, [$F[0],$F[1]]}{ say $_->[0]." ".localtime($_->[1]) for sort { $a->[1] <=> $b->[1] } @rows' in.txt


