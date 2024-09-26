lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 6.486246246246246 --fixed-mass2 72.29273273273273 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1031296864.1912533 \
--gps-end-time 1031304064.1912533 \
--d-distr volume \
--min-distance 1042.140645766119e3 --max-distance 1042.160645766119e3 \
--l-distr fixed --longitude -59.08514404296875 --latitude -21.027437210083008 --i-distr uniform \
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
