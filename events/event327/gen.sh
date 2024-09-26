lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 61.45105105105105 --fixed-mass2 27.74938938938939 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1008000252.4619728 \
--gps-end-time 1008007452.4619728 \
--d-distr volume \
--min-distance 2741.2534178645947e3 --max-distance 2741.273417864595e3 \
--l-distr fixed --longitude 25.09674644470215 --latitude 4.933131694793701 --i-distr uniform \
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
