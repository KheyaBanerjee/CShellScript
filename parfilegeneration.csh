#! /bin/csh
#
# This file creates the parfiles for test and training data 
# March, 2016
#


foreach cont (0.6 1.0 1.2 1.6)

cd /hudson3/kheya/adaptive_vs_lumpy_bkgd/lumpy_bkgd_pinhole/Test/img
cp -f coordfile_r_${cont}_test_c_1.0 /hudson3/kheya/adaptive_vs_lumpy_bkgd/lumpy_bkgd_pinhole/human_observer_lumpy_bkgd_pinhole
cp -f coordfile_r_${cont}_test_c_0.5 /hudson3/kheya/adaptive_vs_lumpy_bkgd/lumpy_bkgd_pinhole/human_observer_lumpy_bkgd_pinhole
cp -f coordfile_r_${cont}_train_c_1.0 /hudson3/kheya/adaptive_vs_lumpy_bkgd/lumpy_bkgd_pinhole/human_observer_lumpy_bkgd_pinhole
cp -f coordfile_r_${cont}_train_c_0.5 /hudson3/kheya/adaptive_vs_lumpy_bkgd/lumpy_bkgd_pinhole/human_observer_lumpy_bkgd_pinhole
cd /hudson3/kheya/adaptive_vs_lumpy_bkgd/lumpy_bkgd_pinhole/human_observer_lumpy_bkgd_pinhole

set k = 1
while (${k} < 26)
set j = `shuf -i 1-100 -n 1`
set fname_abnormal = /hudson3/kheya/adaptive_vs_lumpy_bkgd/lumpy_bkgd_pinhole/Test/img/n_img_test_c_1.0_${j}_r_${cont}
set cord = `sed -n ${j}p coordfile_r_${cont}_test_c_1.0`
echo ${fname_abnormal} >>! parfile_pinhole_${cont}_test
echo ${cord} >>! loclist_pinhole_${cont}_test
@ k = $k + 1
end

end
