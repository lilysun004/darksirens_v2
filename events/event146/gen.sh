lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 11.612932932932932 --fixed-mass2 34.641001001001 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020077479.5976002 \
--gps-end-time 1020084679.5976002 \
--d-distr volume \
--min-distance 783.2715176490574e3 --max-distance 783.2915176490574e3 \
--l-distr fixed --longitude -97.09893798828125 --latitude -74.28746795654297 --i-distr uniform \
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
