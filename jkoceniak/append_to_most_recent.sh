
# append to most recent foo* file (datetime filename)
echo "yup" >> $(ls -t1 foo* | head -n 1)

