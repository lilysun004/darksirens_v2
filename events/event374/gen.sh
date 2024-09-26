lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 23.042922922922923 --fixed-mass2 36.82614614614615 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010014680.2448065 \
--gps-end-time 1010021880.2448065 \
--d-distr volume \
--min-distance 444.0233777477558e3 --max-distance 444.04337774775576e3 \
--l-distr fixed --longitude 35.004638671875 --latitude -28.096710205078125 --i-distr uniform \
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
