lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 4.637277277277278 --fixed-mass2 85.48764764764765 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1013242766.545293 \
--gps-end-time 1013249966.545293 \
--d-distr volume \
--min-distance 510.118634131503e3 --max-distance 510.13863413150295e3 \
--l-distr fixed --longitude 37.22492218017578 --latitude -41.717437744140625 --i-distr uniform \
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
