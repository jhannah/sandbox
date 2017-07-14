sqitch rework 101

If I'm not following Best Practice, please slap me. :)

sqitch init MyProj --engine pg
sqitch add functions/foo
sqitch tag v1 -m "v1"
sqitch rework functions/foo
sqitch tag v2 -m "v2"
sqitch rework functions/foo

sqitch deploy --verify
Deploying changes to db:pg:jhannah
  + functions/foo @v1 .. ok
  + functions/foo @v2 .. ok
  + functions/foo ...... ok

sqitch revert -y
Reverting all changes from db:pg:jhannah
  - functions/foo ...... ok
  - functions/foo @v2 .. ok
  - functions/foo @v1 .. ok
  
