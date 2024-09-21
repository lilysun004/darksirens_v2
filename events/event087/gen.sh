lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 22.286526526526526 --fixed-mass2 84.14294294294295 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1013203204.2253113 \
--gps-end-time 1013210404.2253113 \
--d-distr volume \
--min-distance 2280.076861042069e3 --max-distance 2280.0968610420696e3 \
--l-distr fixed --longitude -8.6842041015625 --latitude -70.6697998046875 --i-distr uniform \
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
