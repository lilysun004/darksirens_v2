lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 46.15503503503504 --fixed-mass2 50.10510510510511 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010595301.5605612 \
--gps-end-time 1010602501.5605612 \
--d-distr volume \
--min-distance 1242.9833147766235e3 --max-distance 1243.0033147766235e3 \
--l-distr fixed --longitude -138.5648651123047 --latitude -66.694580078125 --i-distr uniform \
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
