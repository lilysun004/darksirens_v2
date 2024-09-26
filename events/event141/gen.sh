lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 16.991751751751753 --fixed-mass2 48.08804804804805 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1019051362.9790072 \
--gps-end-time 1019058562.9790072 \
--d-distr volume \
--min-distance 1690.117582075771e3 --max-distance 1690.137582075771e3 \
--l-distr fixed --longitude -2.75872802734375 --latitude 42.35820007324219 --i-distr uniform \
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
