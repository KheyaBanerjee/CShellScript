#! /bin/csh
#

#   THIS IS A BASIC FILE ABOUT C SHELL SCRIPT
#   THIS SHOWS HOW TO COPY, RENAME AND DELETE FILES
#   AS WELL AS MOVING TO SPECIFIC ADDRESSES
#   CHOOSING RANDOM NUMBERS AND SELECTING FILES ARE ALSO SHOWN
#

#
#   HOW TO CHANGE DIRECTORY
#

#   The command to change the directory is "cd"
#   The full address of the directory is provided

cd /hudson1/Image


#
#   HOW TO COPY A FILE 
#

#   The command for copying is "cp"
#   The first one is the source and second one is the target file
#   The -f flag means 'if the file exists'

cp -f coordfile.txt abc.txt

#   Multiple files can be copied with "cp"
#   The last filename is considered as the target file

cp -f coordfile1.txt coordfile2.txt abc.txt

#   File locations can be added with file name

cp -f /hudson1/Image/coordfile.txt /hudson2/Image/coordfile.txt



#
#   HOW TO DELETE A FILE 
#

#   The command to delete a file is "rm"
#   The -f flag means 'if the file exists'
#

rm -f coordfile.txt

#   Multiple files can be deleted with "rm"

rm -f coordfile.txt abc.txt

#   File locations can be added with file name

rm -f /hudson1/Image/coordfile.txt


#
#   HOW TO RENAME A FILE 
#

#   The command to rename a file is mv
#   filey.txt is the destination name

mv filex.txt filey.txt



# 
#   HOW TO SET A VARIABLE
#

#   The command is "set"
#   The variable can be integer/float, string, combination of these
#   It may also contain parameter values (if the command is inside a loop)

set k = 1

foreach r (0.2 0.4 0.6 0.8 1.0 1.2 1.4 1.6 1.8 2.0 2.2 2.4 2.6 2.8 3.0 3.2 3.4 3.6)
set a = xyz_r_${r}
end


#
#   PRINTING A VALUE
#

#   The command for printing is "echo"
#   It can print any value or the value of a variable
#   The values can be printed on screen or file

echo a                                         # prints a 
echo ${a}                                      # prints the value of a 
echo ${a} > file                               # prints the value of a to file
echo ${a} >! file                              # prints the value of a to file, creates file if needed
echo ${a} >>! file                             # appends the value of a to file, creates the file if needed, useful for loops


#
#   HOW TO RUN A FOREACH LOOP ON VARIOUS PARAMETERS
#

#   Here, I have parameters "r", "set" and "m"
#   foreach loop runs through each of the parameter values
#   the variables can be integer/float or string

foreach r (0.2 0.4 0.6 0.8 1.0 1.2 1.4 1.6 1.8 2.0 2.2 2.4 2.6 2.8 3.0 3.2 3.4 3.6)
##############
end

foreach set (train test)
##############
end

foreach m (1 2 3 4)
##############
end 



#
#    HOW TO RUN A WHILE LOOP
#

set k = 1
while (${k} < 101)
##############
@ k = $k + 1
end


#
#   CHOOSING A RANDOM NUMBER
#

#   The command is shuf
#   "i" shows the type of number - integer
#   "1-4000" shows the range of numbers
#   "1" shows how many outputs are needed

set i = `shuf -i 1-4000 -n 1`



#
#   SELCTING A LINE FROM FILE
#

#   The command stores the 5th line
#   from filename to "c"

set c = `sed -n 5p filename`

#   The command stores the ith line
#   from filename to "c"

set c = `sed -n ${i}p filename`


#
#   SELECTING ONLY NUMBERS FROM A FILE
#

set c = `sed -n '/[0-9][0-9][0-9]/p' inputfile >! outputfile`
