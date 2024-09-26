lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 16.57153153153153 --fixed-mass2 59.93825825825826 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1002390392.4568862 \
--gps-end-time 1002397592.4568862 \
--d-distr volume \
--min-distance 610.9170654876568e3 --max-distance 610.9370654876568e3 \
--l-distr fixed --longitude -91.40768432617188 --latitude -26.67499542236328 --i-distr uniform \
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
