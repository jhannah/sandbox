sqitch rework 101

If this isn't Best Practice, please slap me. :)

sqitch init MyProj --engine pg
sqitch add functions/foo
sqitch tag v1 -m "v1"
sqitch rework functions/foo
sqitch tag v2 -m "v2"
sqitch rework functions/foo

