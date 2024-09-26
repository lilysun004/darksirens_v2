lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 26.488728728728727 --fixed-mass2 34.052692692692695 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1019932170.4897991 \
--gps-end-time 1019939370.4897991 \
--d-distr volume \
--min-distance 1257.6488778950607e3 --max-distance 1257.6688778950606e3 \
--l-distr fixed --longitude 163.55010986328125 --latitude -10.257351875305176 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
