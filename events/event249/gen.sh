lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 23.042922922922923 --fixed-mass2 82.46206206206206 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016248643.1069459 \
--gps-end-time 1016255843.1069459 \
--d-distr volume \
--min-distance 1150.2164132669018e3 --max-distance 1150.2364132669018e3 \
--l-distr fixed --longitude -150.07012939453125 --latitude -40.37668991088867 --i-distr uniform \
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
