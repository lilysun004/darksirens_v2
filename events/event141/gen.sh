lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 5.813893893893894 --fixed-mass2 71.95655655655656 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026447158.3498325 \
--gps-end-time 1026454358.3498325 \
--d-distr volume \
--min-distance 638.1597189680706e3 --max-distance 638.1797189680706e3 \
--l-distr fixed --longitude 30.648921966552734 --latitude -18.55793571472168 --i-distr uniform \
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
