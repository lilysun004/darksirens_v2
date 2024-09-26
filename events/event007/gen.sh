lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 28.42174174174174 --fixed-mass2 55.39987987987988 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1004532548.1544333 \
--gps-end-time 1004539748.1544333 \
--d-distr volume \
--min-distance 1443.9868514597676e3 --max-distance 1444.0068514597676e3 \
--l-distr fixed --longitude 103.08644104003906 --latitude -73.79487609863281 --i-distr uniform \
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
