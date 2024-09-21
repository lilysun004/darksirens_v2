lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 11.865065065065064 --fixed-mass2 73.72148148148149 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1003937101.7671127 \
--gps-end-time 1003944301.7671127 \
--d-distr volume \
--min-distance 1112.487049060674e3 --max-distance 1112.507049060674e3 \
--l-distr fixed --longitude 63.172950744628906 --latitude -33.40748596191406 --i-distr uniform \
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
