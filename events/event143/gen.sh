lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 20.017337337337338 --fixed-mass2 47.24760760760761 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1014425699.197109 \
--gps-end-time 1014432899.197109 \
--d-distr volume \
--min-distance 1610.9413934497536e3 --max-distance 1610.9613934497536e3 \
--l-distr fixed --longitude -57.397918701171875 --latitude 40.12946319580078 --i-distr uniform \
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
