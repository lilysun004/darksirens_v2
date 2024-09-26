lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 26.152552552552553 --fixed-mass2 40.103863863863864 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020866102.0305884 \
--gps-end-time 1020873302.0305884 \
--d-distr volume \
--min-distance 2298.7373099589704e3 --max-distance 2298.757309958971e3 \
--l-distr fixed --longitude 6.921609401702881 --latitude -41.85441207885742 --i-distr uniform \
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
