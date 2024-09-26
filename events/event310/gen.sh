lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 10.184184184184184 --fixed-mass2 83.63867867867869 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1013726327.7183415 \
--gps-end-time 1013733527.7183415 \
--d-distr volume \
--min-distance 1192.3022756661494e3 --max-distance 1192.3222756661494e3 \
--l-distr fixed --longitude 131.1114501953125 --latitude -21.314517974853516 --i-distr uniform \
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
