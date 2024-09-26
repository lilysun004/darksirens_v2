lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 50.86150150150151 --fixed-mass2 68.93097097097098 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010347112.2094725 \
--gps-end-time 1010354312.2094725 \
--d-distr volume \
--min-distance 2658.567476413923e3 --max-distance 2658.5874764139235e3 \
--l-distr fixed --longitude 53.88806915283203 --latitude 9.751387596130371 --i-distr uniform \
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
