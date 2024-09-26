lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 7.494774774774775 --fixed-mass2 35.64952952952953 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1015047676.7282287 \
--gps-end-time 1015054876.7282287 \
--d-distr volume \
--min-distance 1221.8173339210784e3 --max-distance 1221.8373339210784e3 \
--l-distr fixed --longitude 59.551025390625 --latitude -32.613914489746094 --i-distr uniform \
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
