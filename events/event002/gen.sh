lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 26.992992992992992 --fixed-mass2 75.99067067067067 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1004104532.8605589 \
--gps-end-time 1004111732.8605589 \
--d-distr volume \
--min-distance 3460.0887197944085e3 --max-distance 3460.108719794409e3 \
--l-distr fixed --longitude -7.42950439453125 --latitude -38.89592742919922 --i-distr uniform \
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
