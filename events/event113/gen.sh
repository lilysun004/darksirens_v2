lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 25.396156156156156 --fixed-mass2 82.20992992992993 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005427199.1227945 \
--gps-end-time 1005434399.1227945 \
--d-distr volume \
--min-distance 1308.7488200639154e3 --max-distance 1308.7688200639154e3 \
--l-distr fixed --longitude -95.41122436523438 --latitude -47.0662841796875 --i-distr uniform \
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
