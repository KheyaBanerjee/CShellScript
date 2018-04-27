#! /bin/csh
#
#    THIS FILE SHOWS HOW TO RUN 
#    AN IDL FILE THROUGH CSHELLSCRIPT
#    THE IDL PROGRAM CAN BE INCLUDED IN THE SCRIPT
#    OR CALLED SEPERATELY 
#


#    IDL PROGRAM CALLED FROM CSHELLSCRIPT

#    The IDL file name is "create_coordfile_2tgt.pro"
#    The function name is "coordfil"
#    The parameters are: parfil1, parfil2, nfils, coordfil
#    "_tmptest.pro" is the temporary file


echo ".run create_coordfile_2tgt.pro" >! _tmptest.pro
echo "coordfil, parfil1='${parfil1}', parfil2='${parfil2}', nfils=${nfils}, coordfil='${coordfil}'" >> _tmptest.pro
idl < _tmptest.pro

rm -f _tmptest.pro


#    IDL PROGRAM IN C SHELL SCRIPT

#    The beginning and end has to be marked with 
#    "cat << end_file >! _tmpp.pro" and "end_file"
#    _tmpp.pro is the temporary file, name can be changed
#    After writing the file, it is compiled using "idl < _tmpp.pro"
#    The lines inside any loop must be ended with "& \$"

set seedval = 5

#
cat << end_file >! _tmpp.pro
seed= ${seedval}
dim= 128L
#
FOR l=0,dim-1 do BEGIN
  FOR m=0,dim-1 & \$
    img[l,m]=1 & \$
  ENDFOR & \$
ENDFOR
#
end_file
#
idl < _tmpp.pro
#
