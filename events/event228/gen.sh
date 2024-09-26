lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 28.42174174174174 --fixed-mass2 76.74706706706706 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1025784411.2549026 \
--gps-end-time 1025791611.2549026 \
--d-distr volume \
--min-distance 398.4288259892576e3 --max-distance 398.44882598925756e3 \
--l-distr fixed --longitude -121.3748779296875 --latitude 25.423192977905273 --i-distr uniform \
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
