lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 19.344984984984983 --fixed-mass2 83.13441441441442 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1012060712.7205878 \
--gps-end-time 1012067912.7205878 \
--d-distr volume \
--min-distance 3058.827504450155e3 --max-distance 3058.8475044501556e3 \
--l-distr fixed --longitude 96.4915771484375 --latitude -33.53822326660156 --i-distr uniform \
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
