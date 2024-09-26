lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 17.916236236236237 --fixed-mass2 38.170850850850854 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026304993.7458074 \
--gps-end-time 1026312193.7458074 \
--d-distr volume \
--min-distance 844.3432165173549e3 --max-distance 844.3632165173549e3 \
--l-distr fixed --longitude -47.6064453125 --latitude 25.800067901611328 --i-distr uniform \
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
