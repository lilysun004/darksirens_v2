lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 15.310870870870872 --fixed-mass2 65.23303303303304 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005840069.0355725 \
--gps-end-time 1005847269.0355725 \
--d-distr volume \
--min-distance 1202.4404616866748e3 --max-distance 1202.4604616866748e3 \
--l-distr fixed --longitude 70.61998748779297 --latitude -76.34111785888672 --i-distr uniform \
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
