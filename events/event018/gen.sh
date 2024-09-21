lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 35.3973973973974 --fixed-mass2 60.35847847847848 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1013488587.8830192 \
--gps-end-time 1013495787.8830192 \
--d-distr volume \
--min-distance 4864.340292391516e3 --max-distance 4864.360292391517e3 \
--l-distr fixed --longitude -63.408721923828125 --latitude -57.61384963989258 --i-distr uniform \
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
