lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 16.57153153153153 --fixed-mass2 66.82986986986987 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010261331.4257208 \
--gps-end-time 1010268531.4257208 \
--d-distr volume \
--min-distance 1535.1508797954866e3 --max-distance 1535.1708797954866e3 \
--l-distr fixed --longitude -14.418487548828125 --latitude 44.5180549621582 --i-distr uniform \
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
