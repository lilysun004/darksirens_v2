lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 22.622702702702703 --fixed-mass2 54.13921921921922 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021750317.394588 \
--gps-end-time 1021757517.394588 \
--d-distr volume \
--min-distance 1471.204648149752e3 --max-distance 1471.224648149752e3 \
--l-distr fixed --longitude 5.657925128936768 --latitude -35.667964935302734 --i-distr uniform \
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
