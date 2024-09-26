lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 37.24636636636637 --fixed-mass2 50.86150150150151 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1022083530.0338763 \
--gps-end-time 1022090730.0338763 \
--d-distr volume \
--min-distance 1174.078219875862e3 --max-distance 1174.098219875862e3 \
--l-distr fixed --longitude -169.59828186035156 --latitude 2.328874111175537 --i-distr uniform \
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
