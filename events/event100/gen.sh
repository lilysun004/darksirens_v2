lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 10.352272272272273 --fixed-mass2 85.82382382382383 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1007071881.0154686 \
--gps-end-time 1007079081.0154686 \
--d-distr volume \
--min-distance 1434.4357061896512e3 --max-distance 1434.4557061896512e3 \
--l-distr fixed --longitude 153.10044860839844 --latitude -40.0250358581543 --i-distr uniform \
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
