lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 4.805365365365366 --fixed-mass2 84.47911911911912 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020192894.2122043 \
--gps-end-time 1020200094.2122043 \
--d-distr volume \
--min-distance 315.5660766205261e3 --max-distance 315.58607662052606e3 \
--l-distr fixed --longitude 154.3175506591797 --latitude 46.95881271362305 --i-distr uniform \
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
