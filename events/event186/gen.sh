lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 20.185425425425425 --fixed-mass2 82.54610610610611 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1013604306.2175058 \
--gps-end-time 1013611506.2175058 \
--d-distr volume \
--min-distance 1481.9343346141964e3 --max-distance 1481.9543346141963e3 \
--l-distr fixed --longitude 0.5759648680686951 --latitude -39.88077926635742 --i-distr uniform \
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
