lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 42.70922922922923 --fixed-mass2 19.765205205205206 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1030353739.8172554 \
--gps-end-time 1030360939.8172554 \
--d-distr volume \
--min-distance 1290.3967435551783e3 --max-distance 1290.4167435551783e3 \
--l-distr fixed --longitude -50.474334716796875 --latitude -45.52450180053711 --i-distr uniform \
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
