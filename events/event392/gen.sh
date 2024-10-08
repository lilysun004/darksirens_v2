lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 41.95283283283283 --fixed-mass2 60.44252252252252 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1006082727.12972 \
--gps-end-time 1006089927.12972 \
--d-distr volume \
--min-distance 4261.266797947291e3 --max-distance 4261.286797947291e3 \
--l-distr fixed --longitude 141.23326110839844 --latitude 29.513694763183594 --i-distr uniform \
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
