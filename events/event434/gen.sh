lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 13.293813813813813 --fixed-mass2 49.93701701701702 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1019409529.5231932 \
--gps-end-time 1019416729.5231932 \
--d-distr volume \
--min-distance 2616.7047831976442e3 --max-distance 2616.7247831976447e3 \
--l-distr fixed --longitude 13.567909240722656 --latitude -1.5289969444274902 --i-distr uniform \
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
