lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 4.805365365365366 --fixed-mass2 54.643483483483486 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1007745817.9677826 \
--gps-end-time 1007753017.9677826 \
--d-distr volume \
--min-distance 1073.934667048293e3 --max-distance 1073.954667048293e3 \
--l-distr fixed --longitude 81.17662048339844 --latitude -69.13172912597656 --i-distr uniform \
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
