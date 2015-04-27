# heh... this doesn't work because it's processing one line of
# input at a time...

perl -p -i -e 's/(?<!no\n  )a/a yes/' in


