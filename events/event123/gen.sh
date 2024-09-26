lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 49.600840840840846 --fixed-mass2 67.67031031031031 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010691219.0347552 \
--gps-end-time 1010698419.0347552 \
--d-distr volume \
--min-distance 1102.448981834921e3 --max-distance 1102.468981834921e3 \
--l-distr fixed --longitude -11.977508544921875 --latitude 8.628372192382812 --i-distr uniform \
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
