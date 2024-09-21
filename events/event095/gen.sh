lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 2.368088088088088 --fixed-mass2 78.00772772772773 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1023547648.5102029 \
--gps-end-time 1023554848.5102029 \
--d-distr volume \
--min-distance 130.4192205768779e3 --max-distance 130.4392205768779e3 \
--l-distr fixed --longitude -34.16888427734375 --latitude 19.488357543945312 --i-distr uniform \
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
