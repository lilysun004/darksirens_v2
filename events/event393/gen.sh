lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 11.52888888888889 --fixed-mass2 45.06246246246246 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010635254.1385729 \
--gps-end-time 1010642454.1385729 \
--d-distr volume \
--min-distance 674.8529932720112e3 --max-distance 674.8729932720112e3 \
--l-distr fixed --longitude -98.388671875 --latitude -4.266995429992676 --i-distr uniform \
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
