lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 12.453373373373374 --fixed-mass2 35.98570570570571 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016697826.2145929 \
--gps-end-time 1016705026.2145929 \
--d-distr volume \
--min-distance 1328.486658976942e3 --max-distance 1328.506658976942e3 \
--l-distr fixed --longitude 84.85102844238281 --latitude -34.89291000366211 --i-distr uniform \
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
