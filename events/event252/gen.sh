lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 40.01981981981982 --fixed-mass2 33.54842842842843 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1011933721.6784544 \
--gps-end-time 1011940921.6784544 \
--d-distr volume \
--min-distance 2236.338529025975e3 --max-distance 2236.3585290259753e3 \
--l-distr fixed --longitude 122.57772064208984 --latitude 54.4495964050293 --i-distr uniform \
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
