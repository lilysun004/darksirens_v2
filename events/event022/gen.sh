lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 22.706746746746745 --fixed-mass2 71.53633633633633 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010025095.6850331 \
--gps-end-time 1010032295.6850331 \
--d-distr volume \
--min-distance 999.8859379176254e3 --max-distance 999.9059379176254e3 \
--l-distr fixed --longitude 138.96128845214844 --latitude -42.81706619262695 --i-distr uniform \
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
