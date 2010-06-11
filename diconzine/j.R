input = read.table(file='/Users/jhannah/src/sandbox/diconzine/input.txt');
if(input[2,2] == 15) { input[2,2] = 22 };
write.table(input, file='/Users/jhannah/src/sandbox/diconzine/output.txt', 
   row.names=FALSE, col.names=FALSE, sep="\t"
);
