lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 24.303583583583585 --fixed-mass2 49.600840840840846 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1009155533.296606 \
--gps-end-time 1009162733.296606 \
--d-distr volume \
--min-distance 1488.0946415285086e3 --max-distance 1488.1146415285086e3 \
--l-distr fixed --longitude -29.433563232421875 --latitude -34.09596633911133 --i-distr uniform \
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
