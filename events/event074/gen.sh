lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 41.364524524524526 --fixed-mass2 58.08928928928929 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1018759135.2335196 \
--gps-end-time 1018766335.2335196 \
--d-distr volume \
--min-distance 2615.8515993466235e3 --max-distance 2615.871599346624e3 \
--l-distr fixed --longitude 171.66021728515625 --latitude 25.401342391967773 --i-distr uniform \
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
