lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 29.43027027027027 --fixed-mass2 35.98570570570571 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010028370.1027004 \
--gps-end-time 1010035570.1027004 \
--d-distr volume \
--min-distance 3011.907966293038e3 --max-distance 3011.9279662930385e3 \
--l-distr fixed --longitude -161.4007568359375 --latitude -4.439610481262207 --i-distr uniform \
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
