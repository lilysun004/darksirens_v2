lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 49.264664664664664 --fixed-mass2 20.353513513513512 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1027687832.8882176 \
--gps-end-time 1027695032.8882176 \
--d-distr volume \
--min-distance 3272.3739718652214e3 --max-distance 3272.393971865222e3 \
--l-distr fixed --longitude -142.37295532226562 --latitude -45.02523422241211 --i-distr uniform \
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
