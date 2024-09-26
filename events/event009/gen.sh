lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 28.926006006006006 --fixed-mass2 29.682402402402403 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010960818.8464557 \
--gps-end-time 1010968018.8464557 \
--d-distr volume \
--min-distance 779.8260277645319e3 --max-distance 779.8460277645319e3 \
--l-distr fixed --longitude 62.29441452026367 --latitude -31.24532127380371 --i-distr uniform \
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
