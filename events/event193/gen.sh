lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 16.235355355355356 --fixed-mass2 61.28296296296297 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000770135.4927602 \
--gps-end-time 1000777335.4927602 \
--d-distr volume \
--min-distance 421.20999649707295e3 --max-distance 421.22999649707293e3 \
--l-distr fixed --longitude -147.17372131347656 --latitude -3.3817923069000244 --i-distr uniform \
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
