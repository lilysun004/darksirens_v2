lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 10.268228228228228 --fixed-mass2 73.04912912912913 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020759370.0054967 \
--gps-end-time 1020766570.0054967 \
--d-distr volume \
--min-distance 837.7583824741201e3 --max-distance 837.7783824741201e3 \
--l-distr fixed --longitude -4.061065673828125 --latitude -32.04921340942383 --i-distr uniform \
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
