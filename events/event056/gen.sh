lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 19.176896896896896 --fixed-mass2 17.411971971971973 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1006263964.9166183 \
--gps-end-time 1006271164.9166183 \
--d-distr volume \
--min-distance 1141.1277533997397e3 --max-distance 1141.1477533997397e3 \
--l-distr fixed --longitude 3.74642014503479 --latitude 4.668859958648682 --i-distr uniform \
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
