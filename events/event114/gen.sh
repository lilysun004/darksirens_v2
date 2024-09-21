lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 21.53013013013013 --fixed-mass2 14.974694694694694 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1024971934.1411519 \
--gps-end-time 1024979134.1411519 \
--d-distr volume \
--min-distance 1511.8609202388773e3 --max-distance 1511.8809202388773e3 \
--l-distr fixed --longitude -99.60125732421875 --latitude 31.064537048339844 --i-distr uniform \
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
