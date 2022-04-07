perl -pE "s{('[^']+')}{\$1 =~ s/:/./gr}ge;" test_sample.tree

