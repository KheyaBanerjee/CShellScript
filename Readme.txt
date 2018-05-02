This file describes the files in CShellScript repository.


The example scripts are included here: 
1. 'basiccshellscript.csh' 
2. 'IDLfromShellscript.csh'
3. 'parfilegeneration.csh'
4. 'humanresvarrcl.csh'
	1. 'convert_classification2localization.pro' 
	2. 'empiricalLROC_tgtsp'
	3. 'study_pinhole_0.6_c_1.0_kheya.out'




The description for file "basiccshellscript.csh"

This file shows basic operations like change directory, copy, delete, rename etc. It also shows how to generate a random number
and pick a particular line from a file. The selection of some elements from a file is also shown here.



The description for file "IDLfromShellscript.csh"

This file shows 2 different ways of running an IDL code.file from C shell script.



The description for file "parfilegeneration.csh"

This is an example how to generate a text file with varying parameters. It generates file locations by varying parameters.



The description for file "humanresvarrcl.csh"

This file needs 2 other files: 'convert_classification2localization.pro' and 'empiricalLROC_tgtsp'
The first IDL file converts a target specific input to a non target specific output and the second C execuatble performs an LROC test on the output file.




The description for file "create_filecoordinate.csh"

This file generates a text file which contains all the names of the reconstructed images. The name of the images have the locations of tumor 
so the location file is called and the location is added to the filename.
