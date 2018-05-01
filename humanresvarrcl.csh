#!/bin/csh

# THIS FILE CONVERTS THE TARGET-SPECIFIC DATA
# TO NON TARGET-SPECIFIC ONE BY CALLING THE IDL FUNCTION
# 'convert_classification2localization.pro'

# IN THE SECOND PART, THE NON TARGET-SPECIFIC OUTPUT 
# IS ANALYSED BY AN LROC CODE 'empiricalLROC_tgtsp' 
# WHICH IS A C EXECUTABLE

foreach r (0.6 1.0 1.2 1.6)
#foreach r (0.6)

foreach shape (c_1.0 c_0.5)
#foreach shape (c_0.5)

foreach obs (hongwei kheya gifford)
#foreach obs (gifford)

set fname_area = study_pinhole_${r}_${shape}_${obs}.out
set fname_out = study_pinhole_${r}_${shape}_${obs}_localization.out

cd /hudson3/kheya/lumpy_bkgd_classification/human_observer_lumpy_bkgd_pinhole
cp -p ${fname_area} /hudson3/kheya/plots/lumpy_bkgd_classification_varN/humanresvarrcl
cd /hudson3/kheya/plots/lumpy_bkgd_classification_varN/humanresvarrcl

echo ".run convert_classification2localization.pro" >! _tmptest.pro
echo "result, fname_area='${fname_area}', fname_out='${fname_out}'" >>! _tmptest.pro
idl < _tmptest.pro

rm -f ${fname_area} _tmptest.pro

end

end

end


###########################################

foreach r (0.6 1.0 1.2 1.6)
#foreach r (0.6)

foreach shape (c_1.0 c_0.5)
#foreach shape (c_0.5)

foreach obs (hongwei kheya gifford)
#foreach obs (gifford)

foreach rcl (0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)
#foreach rcl (0)

set fname_out = study_pinhole_${r}_${shape}_${obs}_localization.out

cd /hudson3/kheya/plots/lumpy_bkgd_classification_varN/humanresvarrcl

./empiricalLROC_tgtsp -i ${fname_out} -rcl ${rcl} -x >>! pinhole_${r}_${shape}_${obs}_rcl${rcl}

end

rm -f  ${fname_out}

end

end

end



cat << end_file >! _tmpp.pro

rcl = indgen(21)
rat = [0.6,1.0,1.2,1.6]
shape = ['c_1.0','c_0.5']
obs = ['gifford','kheya','hongwei']

vobs = fltarr(21,2,4,3)

;FOR k=0,0 DO BEGIN & \$                       ; OBSERVERS
FOR k=0,2 DO BEGIN & \$

;FOR l=0,0 DO BEGIN & \$                       ; PINHOLE SIZES
FOR l=0,3 DO BEGIN & \$

;FOR m=1,1 DO BEGIN & \$                       ; TARGET SIZE
FOR m=0,1 DO BEGIN & \$

FOR n=0,20 DO BEGIN & \$                      ; RCL VALUES
;FOR n=0,0 DO BEGIN & \$       

areasettemp = '' & \$
filearr = strarr(1,100) & \$

fname = 'pinhole_'+string(rat[l],FORMAT='(F3.1)')+'_'+strtrim(shape[m],2)+'_'+strtrim(obs[k],2)+'_rcl'+strtrim(rcl[n],2) & \$

openr, 1, fname & \$ ; 'pinhole_0.6_c_0.5_gifford_rcl0' 

aind = 0 & \$
while ~ eof(1) do begin & \$
   readf, 1, areasettemp & \$
   filearr(*,aind) = areasettemp & \$
   aind = aind+1 & \$
endwhile & \$
free_lun,1 & \$
filearr = filearr(*,0:aind-1) & \$

area = filearr[where(strpos(filearr, 'Correct localizations=') gt 0)] & \$
vobs[n,m,l,k] = float(strmid(area, 27, 8)) & \$

ENDFOR & \$

ENDFOR & \$

ENDFOR & \$

ENDFOR

print, vobs

; PLOTTING DATA FULL TARGET

;p1 = PLOT(rcl,vobs[*,0,0,0],LINESTYLE=0,SYMBOL='*',YRANGE=[0,26], ytitle='# Hits', xtitle='Radius of Correct Localization (RCL)')
;p2 = PLOT(rcl,vobs[*,0,1,0],LINESTYLE=1,SYMBOL='*',/OVERPLOT)
;p3 = PLOT(rcl,vobs[*,0,2,0],LINESTYLE=2,SYMBOL='*',/OVERPLOT)
;p4 = PLOT(rcl,vobs[*,0,3,0],LINESTYLE=3,SYMBOL='*',/OVERPLOT)

;p5 = PLOT(rcl,vobs[*,0,0,1],LINESTYLE=0,SYMBOL='o',/OVERPLOT)
;p6 = PLOT(rcl,vobs[*,0,1,1],LINESTYLE=1,SYMBOL='o',/OVERPLOT)
;p7 = PLOT(rcl,vobs[*,0,2,1],LINESTYLE=2,SYMBOL='o',/OVERPLOT)
;p8 = PLOT(rcl,vobs[*,0,3,1],LINESTYLE=3,SYMBOL='o',/OVERPLOT)

;p9 = PLOT(rcl,vobs[*,0,0,2],LINESTYLE=0,SYMBOL='+',/OVERPLOT)
;p10 = PLOT(rcl,vobs[*,0,1,2],LINESTYLE=1,SYMBOL='+',/OVERPLOT)
;p11 = PLOT(rcl,vobs[*,0,2,2],LINESTYLE=2,SYMBOL='+',/OVERPLOT)
;p12 = PLOT(rcl,vobs[*,0,3,2],LINESTYLE=3,SYMBOL='+',/OVERPLOT)

;p1.Save, "humanresvarrcl.eps", BORDER=10, RESOLUTION=300, /TRANSPARENT


;vobs1 = vobs[*,0,0,0]+vobs[*,0,0,1]+vobs[*,0,0,2]
;vobs2 = vobs[*,0,1,0]+vobs[*,0,1,1]+vobs[*,0,1,2]
;vobs3 = vobs[*,0,2,0]+vobs[*,0,2,1]+vobs[*,0,2,2]
;vobs4 = vobs[*,0,3,0]+vobs[*,0,3,1]+vobs[*,0,3,2]

;p1 = PLOT(rcl,vobs1,LINESTYLE=0,YRANGE=[0,76], ytitle='# Hits', xtitle='Radius of Correct Localization (RCL)', title='Human Observer detection performance for full target with RCL 0~20')
;p2 = PLOT(rcl,vobs2,LINESTYLE=1,/OVERPLOT)
;p3 = PLOT(rcl,vobs3,LINESTYLE=2,/OVERPLOT)
;p4 = PLOT(rcl,vobs4,LINESTYLE=3,/OVERPLOT)

;p1.Save, "humanresvarrcl_fulltarget.eps", BORDER=10, RESOLUTION=300, /TRANSPARENT


;vobs1 = vobs[*,1,0,0]+vobs[*,1,0,1]+vobs[*,1,0,2]
;vobs2 = vobs[*,1,1,0]+vobs[*,1,1,1]+vobs[*,1,1,2]
;vobs3 = vobs[*,1,2,0]+vobs[*,1,2,1]+vobs[*,1,2,2]
;vobs4 = vobs[*,1,3,0]+vobs[*,1,3,1]+vobs[*,1,3,2]

;p1 = PLOT(rcl,vobs1,LINESTYLE=0,YRANGE=[0,76], ytitle='# Hits', xtitle='Radius of Correct Localization (RCL)', title='Human Observer detection performance for half target with RCL 0~20')
;p2 = PLOT(rcl,vobs2,LINESTYLE=1,/OVERPLOT)
;p3 = PLOT(rcl,vobs3,LINESTYLE=2,/OVERPLOT)
;p4 = PLOT(rcl,vobs4,LINESTYLE=3,/OVERPLOT)

;p1.Save, "humanresvarrcl_halftarget.eps", BORDER=10, RESOLUTION=300, /TRANSPARENT


vobs1 = vobs[*,0,0,0]+vobs[*,0,0,1]+vobs[*,0,0,2]+vobs[*,1,0,0]+vobs[*,1,0,1]+vobs[*,1,0,2]
vobs2 = vobs[*,0,1,0]+vobs[*,0,1,1]+vobs[*,0,1,2]+vobs[*,1,1,0]+vobs[*,1,1,1]+vobs[*,1,1,2]
vobs3 = vobs[*,0,2,0]+vobs[*,0,2,1]+vobs[*,0,2,2]+vobs[*,1,2,0]+vobs[*,1,2,1]+vobs[*,1,2,2]
vobs4 = vobs[*,0,3,0]+vobs[*,0,3,1]+vobs[*,0,3,2]+vobs[*,1,3,0]+vobs[*,1,3,1]+vobs[*,1,3,2]

p1 = PLOT(rcl,vobs1,LINESTYLE=0,THICK=3,YRANGE=[0,151], ytitle='Number of Hits', xtitle='Radius of Correct Localization (RCL)')
p2 = PLOT(rcl,vobs2,LINESTYLE=0,THICK=3,/OVERPLOT)
p3 = PLOT(rcl,vobs3,LINESTYLE=0,THICK=3,/OVERPLOT)
p4 = PLOT(rcl,vobs4,LINESTYLE=0,THICK=3,/OVERPLOT)

p1.Save, "humanresvarrcl_combinedtarget.eps", BORDER=10, RESOLUTION=300, /TRANSPARENT


end_file
#
idl < _tmpp.pro
#
rm -f _tmpp.pro
