lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 6.4022022022022025 --fixed-mass2 22.37057057057057 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1028427898.5496378 \
--gps-end-time 1028435098.5496378 \
--d-distr volume \
--min-distance 1522.6321859644272e3 --max-distance 1522.6521859644272e3 \
--l-distr fixed --longitude -3.604339599609375 --latitude 37.4406623840332 --i-distr uniform \
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
