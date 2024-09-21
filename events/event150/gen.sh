lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 18.84072072072072 --fixed-mass2 37.4984984984985 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1015992734.0578943 \
--gps-end-time 1015999934.0578943 \
--d-distr volume \
--min-distance 2157.0000187541295e3 --max-distance 2157.02001875413e3 \
--l-distr fixed --longitude 139.64974975585938 --latitude 24.82172203063965 --i-distr uniform \
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
