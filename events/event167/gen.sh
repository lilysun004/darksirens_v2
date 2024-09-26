lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 58.42546546546547 --fixed-mass2 54.643483483483486 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021675556.7599999 \
--gps-end-time 1021682756.7599999 \
--d-distr volume \
--min-distance 2869.2612672133682e3 --max-distance 2869.2812672133687e3 \
--l-distr fixed --longitude -32.489990234375 --latitude -14.50379753112793 --i-distr uniform \
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
