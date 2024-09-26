lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 7.999039039039039 --fixed-mass2 34.72504504504505 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1022266519.7827303 \
--gps-end-time 1022273719.7827303 \
--d-distr volume \
--min-distance 1145.0025787789502e3 --max-distance 1145.0225787789502e3 \
--l-distr fixed --longitude -158.40235900878906 --latitude -58.27046203613281 --i-distr uniform \
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
