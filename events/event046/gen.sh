lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 62.711711711711715 --fixed-mass2 62.62766766766767 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1011045608.8490683 \
--gps-end-time 1011052808.8490683 \
--d-distr volume \
--min-distance 2702.6994642080454e3 --max-distance 2702.719464208046e3 \
--l-distr fixed --longitude -174.71571350097656 --latitude -17.00827980041504 --i-distr uniform \
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
