lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 46.407167167167174 --fixed-mass2 44.306066066066066 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1008651486.9980135 \
--gps-end-time 1008658686.9980135 \
--d-distr volume \
--min-distance 3171.776883716565e3 --max-distance 3171.7968837165654e3 \
--l-distr fixed --longitude -33.171722412109375 --latitude -44.25233840942383 --i-distr uniform \
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
