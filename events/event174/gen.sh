lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 31.11115115115115 --fixed-mass2 59.26590590590591 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1006174385.0832802 \
--gps-end-time 1006181585.0832802 \
--d-distr volume \
--min-distance 1729.8725739967213e3 --max-distance 1729.8925739967212e3 \
--l-distr fixed --longitude 68.48249816894531 --latitude -57.9259033203125 --i-distr uniform \
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
